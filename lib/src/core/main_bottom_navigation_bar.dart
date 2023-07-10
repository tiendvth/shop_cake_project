// File page_view_bottom_navigation
// @project food
// @author phanmanhha198 on 16-07-2021

import 'package:common/src//core/navigator_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef BottomNavigatorItemBuilder = Widget Function(BuildContext contextNavigation, int currentIndex);

class MainBottomNavigationBar extends StatefulWidget {
  final List<Widget> children;
  final List<bool>? wantKeepAliveChildren;
  final BottomNavigatorItemBuilder bottomNavigatorItemBuilder;
  final int defaultIndex;
  final Future<bool>? exitMain;

  const MainBottomNavigationBar(
      {Key? key,
      required this.children,
      this.wantKeepAliveChildren,
      this.defaultIndex = 0,
      required this.bottomNavigatorItemBuilder,
      this.exitMain})
      : assert(children.length > 0),
        assert(wantKeepAliveChildren == null || (wantKeepAliveChildren.length == children.length)),
        super(key: key);

  @override
  State<MainBottomNavigationBar> createState() => _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> with MainBottomNavigationBarMixin {
  @override
  BottomNavigatorItemBuilder get bottomNavigatorItemBuilder => widget.bottomNavigatorItemBuilder;

  @override
  List<Widget> get children => widget.children;

  @override
  int get defaultIndex => widget.defaultIndex;

  @override
  Future<bool>? get exitMain => widget.exitMain;

  @override
  List<bool>? get wantKeepAliveChildren => widget.wantKeepAliveChildren;
}

class TabBarController extends ValueNotifier<int> {
  final PageController controller;
  final Map<int, GlobalKey<NavigatorState>> navigatorKeys;
  final int maxTapPopUntil;

  TabBarController(this.controller, this.navigatorKeys, {int? defaultIndex, this.maxTapPopUntil = 2})
      : super(defaultIndex ?? 0);

  int _tapDouble = 0;

  set tabIndex(int index) {
    if (value != index) {
      controller.jumpToPage(index);
      value = index;
      _tapDouble = 0;
    } else {
      _tapDouble++;
    }
    if (_tapDouble >= maxTapPopUntil) {
      var checkChild = navigatorKeys[index]?.currentState?.canPop();
      if (checkChild == true) {
        navigatorKeys[index]?.currentState?.popUntil((route) => route.isFirst);
      }
      _tapDouble = 0;
    }
  }

  GlobalKey<NavigatorState>? get navigatorKeyCurrent => navigatorKeys[value];
}

mixin MainBottomNavigationBarMixin<T extends StatefulWidget> on State<T> {
  late PageController _pageController;
  late TabBarController _tabBarController;
  final Map<int, GlobalKey<NavigatorState>> _navigatorKeys = {};
  List<Widget> _children = List.empty();

  List<Widget> get children;

  int get defaultIndex;

  List<bool>? get wantKeepAliveChildren;

  Future<bool>? get exitMain;

  BottomNavigatorItemBuilder get bottomNavigatorItemBuilder;

  @mustCallSuper
  @override
  void initState() {
    _pageController = PageController(initialPage: defaultIndex, keepPage: true);
    _children = List.generate(children.length, (index) {
      final child = children[index];
      final navigatorKey = GlobalKey<NavigatorState>();
      final wantKeepAlive = wantKeepAliveChildren?.elementAt.call(index);
      _navigatorKeys[index] = navigatorKey;
      return NestNavigationItem(navigatorKey: navigatorKey, wantKeepAlive: wantKeepAlive, child: child);
    });
    _tabBarController = TabBarController(_pageController, _navigatorKeys, defaultIndex: defaultIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _tabBarController,
        builder: (contextProvider, child) {
          return Scaffold(
              body: WillPopScope(
                onWillPop: () async {
                  final currentIndex = contextProvider.read<TabBarController>().value;
                  final navigatorCurrent = contextProvider.read<TabBarController>().navigatorKeyCurrent;
                  final navigatorState = navigatorCurrent?.currentState;
                  final canPop = navigatorState?.canPop();
                  if (canPop == true) {
                    await navigatorState?.maybePop();
                  } else {
                    if (currentIndex == defaultIndex) {
                      return exitMain ?? Future.value(true);
                    } else {
                      contextProvider.read<TabBarController>().tabIndex = defaultIndex;
                    }
                  }
                  return false;
                },
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (index) {
                    contextProvider.read<TabBarController>().value = index;
                  },
                  children: _children,
                ),
              ),
              bottomNavigationBar: Consumer<TabBarController>(
                builder: (BuildContext context, value, Widget? child) {
                  return bottomNavigatorItemBuilder(context, value.value);
                },
              ));
        });
  }

  @override
  void dispose() {
    _pageController.dispose();
    // _tabBarController.dispose();
    super.dispose();
  }
}

class NestNavigationItem extends StatefulWidget {
  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;
  final bool? wantKeepAlive;

  const NestNavigationItem({Key? key, required this.child, required this.navigatorKey, this.wantKeepAlive})
      : super(key: key);

  @override
  State<NestNavigationItem> createState() => _NestNavigationItemState();
}

class _NestNavigationItemState extends State<NestNavigationItem> with AutomaticKeepAliveClientMixin, NestNavigationMixin {
  @override
  bool get wantKeepAlive => widget.wantKeepAlive ?? true;

  @override
  Widget get child => widget.child;

  @override
  GlobalKey<NavigatorState> get navigatorKey => widget.navigatorKey;
}
