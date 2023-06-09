import 'package:common/common.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/common/%20config/format_price.dart';
import 'package:shop_cake/common/badge_widget.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/firebase/setup_firebase.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/detail_food/ui/detail_food_page.dart';
import 'package:shop_cake/src/detail_my_order/ui/detail_my_order_page.dart';
import 'package:shop_cake/src/list_food/components/item_card.dart';
import 'package:shop_cake/src/home_page/repository/home_repository.dart';
import 'package:shop_cake/src/list_food/bloc/category_cubit.dart';
import 'package:shop_cake/src/list_food/bloc/list_food_cubit.dart';
import 'package:shop_cake/src/list_food/components/input_search.dart';
import 'package:shop_cake/widgets/c_image.dart';

import '../../../constants/font_size/font_size.dart';

class ListFoodPage extends StatefulWidget {
  const ListFoodPage({Key? key}) : super(key: key);

  @override
  State<ListFoodPage> createState() => _ListFoodPageState();
}

class _ListFoodPageState extends State<ListFoodPage> {
  final listFoodCubit = ListFoodCubit();
  final listCategoryCubit = CategoryCubit();
  final homeRepository = HomeRepositoryImpl(apiProvider);

  get state => null;

  saveDeviceToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      print("device_tokent: " + token.toString());
      device_token = token ?? '';
      await homeRepository.deviceToken(token.toString());
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    // saveDeviceToken();
    // tabController = TabController(length: 4, vsync: this, initialIndex: 0);

    FirebaseMessaging.onMessage.listen(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print("Data message firebase: ${message.data}");
        NavigatorManager.pushFullScreen(
            context,
            DetailMyOrder(
              id: int.parse(message.data['orderId']),
            ));
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Data message firebase: ${message.data}");
      Future.delayed(const Duration(milliseconds: 2000), () {
        NavigatorManager.pushFullScreen(
            context,
            DetailMyOrder(
              id: int.parse(message.data['orderId']),
            ));
      });
    });
    _refresh();
  }

  Future<void> _refresh() async {
    listFoodCubit.getListFood(listFoodCubit.searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => listFoodCubit,
        ),
        BlocProvider(
          create: (_) => listCategoryCubit,
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xfFFFFFFF),
        body: SafeArea(
          top: false,
          bottom: true,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  gradient: kBgMenu,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 56,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Text(
                            "Sản phẩm",
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: kMainDarkColor,
                              ),
                            ),
                          ),
                        ),
                        Badge(
                          value: '3',
                          child: InkWell(
                            onTap: () {},
                            child: const CImage(
                              assetsPath: Assets.icNotification,
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputSearch(
                      controller: listFoodCubit.searchController,
                      maxWidth: double.infinity,
                      prefixIcon: const Icon(
                        Icons.search_outlined,
                        color: Colors.grey,
                      ),
                      listFoodCubit: listFoodCubit,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Tất cả sản phẩm',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: BlocBuilder<ListFoodCubit, ListFoodState>(
                        builder: (context, stateListCake) {
                          if (stateListCake is ListFoodSuccess) {
                            return RefreshIndicator(
                              onRefresh: _refresh,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 16),
                                  child: Column(
                                    children: [
                                      GridView.custom(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 12,
                                          crossAxisSpacing: 12,
                                          childAspectRatio: 0.7,
                                        ),
                                        childrenDelegate:
                                            SliverChildBuilderDelegate(
                                          (context, index) => ItemCard(
                                            imageUrl: stateListCake.data['result']
                                                [index]['image'],
                                            title: stateListCake.data['result']
                                                [index]['name'],
                                            price: FormatPrice.formatVND(
                                                stateListCake.data['result']
                                                    [index]['price']),
                                            onTap: () {
                                              NavigatorManager.pushFullScreen(
                                                  context,
                                                  DetailFood(
                                                    id: stateListCake
                                                                .data['result']
                                                            [index]['id'] ??
                                                        '',
                                                    detail: stateListCake
                                                        .data['result'][index],
                                                  ));
                                            },
                                            addToCart: () {
                                              listFoodCubit.addFoodToOrder(
                                                context,
                                                cakeId:
                                                    stateListCake.data['result']
                                                        [index]['cakeId'],
                                                quantity:
                                                    stateListCake.data['result']
                                                            [index]['quantity'] ??
                                                        1,
                                              );
                                            },
                                          ),
                                          childCount:
                                              stateListCake.data['result'].length,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else if (state is ListFoodFailure) {
                            return Center(
                              child: Text(
                                state.message,
                                style: TextStyle(
                                    fontSize: FontSize.fontSize_16,
                                    color: FontColor.color212121),
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: kMainColor,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
