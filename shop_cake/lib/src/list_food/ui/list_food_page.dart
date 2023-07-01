import 'package:common/common.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
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
import 'package:shop_cake/src/list_food/components/category_item.dart';
import 'package:shop_cake/src/list_food/components/input_search.dart';
import 'package:shop_cake/validation/validation.dart';
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
    listCategoryCubit.getCategory();
    listFoodCubit.getListFood(listFoodCubit.searchController.text);
  }

  // Future<void> _refresh() async {
  //   await listFoodCubit.getListFood(listFoodCubit.searchController.text);
  // }

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
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
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
                        const CImage(
                          assetsPath: Assets.icNotification,
                          height: 24,
                          width: 24,
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
                    // BlocBuilder<CategoryCubit, CategoryState>(
                    //   builder: (context, state) {
                    //     if (state is CategorySuccess) {
                    //       // print('state: $state');
                    //       return SizedBox(
                    //         height: 40,
                    //         child: ListView.builder(
                    //           shrinkWrap: true,
                    //           itemCount: state.data.length,
                    //           // itemCount: 10,
                    //           scrollDirection: Axis.horizontal,
                    //           itemBuilder: (context, index) {
                    //             return Padding(
                    //               padding: const EdgeInsets.only(left: 15, right: 15),
                    //               child: CategoryItem(
                    //                 // imageUrl: state.data[index]['image'],
                    //                 title: state.data[index]['name'],
                    //                 // title: 'category',
                    //               ),
                    //             );
                    //           },
                    //         ),
                    //       );
                    //     } else {
                    //       return SizedBox.shrink();
                    //     }
                    //   },
                    // ),
                    Expanded(
                      child: BlocBuilder<ListFoodCubit, ListFoodState>(
                        builder: (context, stateListCake) {
                          if (stateListCake is ListFoodSuccess) {
                            return SingleChildScrollView(
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
                                        (context, index) => const ItemCard(),
                                        childCount: 10,
                                      ),
                                    ),
                                  ],
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
                          return const SizedBox.shrink();
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
