import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/src/Menu/ui/menu_screen.dart';
import 'package:shop_cake/src/cart_page/ui/cart_page.dart';
import 'package:shop_cake/src/create_my_order/ui/create_my_order_page.dart';
import 'package:shop_cake/src/home_page/ui/home_page.dart';
import 'package:shop_cake/src/list_food/ui/list_food_page.dart';
import 'package:shop_cake/widgets/c_image.dart';


class AppHome extends StatefulWidget {
  final AuthenticationStatus? openLogin;

  const AppHome({Key? key, this.openLogin}) : super(key: key);

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> with SingleTickerProviderStateMixin {
  // late TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainBottomNavigationBar(
        wantKeepAliveChildren: [true, true, false, false, false],
        bottomNavigatorItemBuilder: (BuildContext contextNavigation, int currentIndex) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.pink,
            elevation: 1,
            currentIndex: currentIndex,
            onTap: (index) {
              contextNavigation.read<TabBarController>().tabIndex = index;
            },
            items: const [
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 22,
                  height: 22,
                  child: CImage(
                    assetsPath: Assets.icHome,
                  ),
                ),
                activeIcon: SizedBox(
                    width: 22,
                    height: 22,
                    child: CImage(
                     assetsPath: Assets.icHome,
                      color: Colors.pink,
                    )),
                label: 'Trang chủ',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 22,
                  height: 22,
                  child: CImage(
                    assetsPath: Assets.icCake,
                  ),
                ),
                activeIcon: SizedBox(
                    width: 22,
                    height: 22,
                    child: CImage(
                      assetsPath: Assets.icCake,
                      color: Colors.pink,
                    )),
                label: 'Sản phẩm',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 22,
                  height: 22,
                  child: CImage(
                    assetsPath: Assets.icCreateOder,
                  ),
                ),
                activeIcon: SizedBox(
                    width: 22,
                    height: 22,
                    child: CImage(
                      assetsPath: Assets.icCreateOder,
                      color: Colors.pink,
                    )),
                label: 'Tạo đơn',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 22,
                  height: 22,
                  child: CImage(
                    assetsPath: Assets.icCart,
                  ),
                ),
                activeIcon: SizedBox(
                    width: 22,
                    height: 22,
                    child: CImage(
                      assetsPath: Assets.icCart,
                      color: Colors.pink,
                    )),
                label: 'Giỏ hàng',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 22,
                  height: 22,
                  child: CImage(
                    assetsPath: Assets.icMenu,
                  ),
                ),
                activeIcon: SizedBox(
                    width: 22,
                    height: 22,
                    child: CImage(
                      assetsPath: Assets.icMenu,
                      color: Colors.pink,
                    )),
                label: 'Menu',
              ),
            ],
          );
        },
        children: const [
          HomePage(),
          ListFoodPage(),
          CreateMyOrderPage(),
          CartPage(
            isShowIconBack: false,
          ),
          MenuScreen(),
        ],
      ),
    );
  }
}
