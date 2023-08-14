import 'package:common/common.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/common/config/string_service.dart';
import 'package:shop_cake/common/config_read_file.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/firebase/setup_firebase.dart';
import 'package:shop_cake/src/detail_food/ui/detail_food_page.dart';
import 'package:shop_cake/src/detail_my_order/ui/detail_my_order_page.dart';
import 'package:shop_cake/src/list_food/components/item_card.dart';
import 'package:shop_cake/src/list_food/bloc/list_food_cubit.dart';

class ListPromotionScreen extends StatefulWidget {
  const ListPromotionScreen({Key? key}) : super(key: key);

  @override
  State<ListPromotionScreen> createState() => _ListPromotionScreenState();
}

class _ListPromotionScreenState extends State<ListPromotionScreen> {
  final listFoodCubit = ListFoodCubit();

  @override
  void initState() {
    super.initState();
    // saveDeviceToken();
    // tabController = TabController(length: 4, vsync: this, initialIndex: 0);

    FirebaseMessaging.onMessage.listen(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {
          print("Data message firebase: ${message.data}");
          NavigatorManager.pushFullScreen(
            context,
            DetailMyOrder(
              id: int.parse(message.data['orderId']),
            ),
          );
        }
      },
    );
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
    listFoodCubit.getListFood(
      listFoodCubit.searchController.text,
      null,
      null,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => listFoodCubit,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kMainColor,
          title: Text(
            'Sản phẩm khuyến mãi',
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: kMainDarkColor,
              ),
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kMainDarkColor,
            ),
          ),
        ),
        backgroundColor: const Color(0xfFFFFFFF),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Tất cả sản phẩm',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<ListFoodCubit, ListFoodState>(
                  builder: (context, state) {
                    if (state is ListFoodLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kMainColor,
                        ),
                      );
                    } else if (state is ListFoodSuccess &&
                        state.data['result'] != null &&
                        state.data['result'].length > 0) {
                     // lọc ra toàn bộ sản phẩm có discount
                      List<dynamic> listDiscount = [];
                      for (int i = 0; i < state.data['result'].length; i++) {
                        if (state.data['result'][i]['discount'] != null) {
                          listDiscount.add(state.data['result'][i]);
                        } else {
                          return Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 64),
                            child: Center(
                              child: Text(
                                "Không có sản phẩm nào.",
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }
                      return GridView.custom(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.7,
                        ),
                        childrenDelegate: SliverChildBuilderDelegate(
                          (context, index) {
                            // lấy ra các sản phẩm có discount
                                return ItemCard(
                                  title: listDiscount[index]['name'],
                                  imageUrl: ReadFile.readFile(
                                      listDiscount[index]['image']),
                                  isPromotion: true,
                                  promotionSale:
                                      'Sale ${StringService.formatDiscount(
                                        listDiscount[index]['discount'],)}%',
                                  onTap: () {
                                    NavigatorManager.push(
                                      context,
                                      DetailFood(
                                        id: listDiscount[index]['id'],
                                        detail: listDiscount[index],
                                      ),
                                    );
                                  },
                                );

                              // return ItemCard(
                              //   // id: state.data['result'][i]['id'],
                              //   // name: state.data['result'][i]['name'],
                              //   // price: state.data['result'][i]['price'],
                              //   // discount: state.data['result'][i]['discount'],
                              //   // image: state.data['result'][i]['image'],
                              //   title: state.data['result'][index]['name'],
                              //   imageUrl: ReadFile.readFile(
                              //       state.data['result'][index]['image']),
                              //   isPromotion: true,
                              //   promotionSale:
                              //       'Sale ${StringService.formatDiscount(state.data['result'][index]['discount'])}%',
                              //   onTap: () {
                              //     NavigatorManager.push(
                              //       context,
                              //       DetailFood(
                              //         id: state.data['result'][index]['id'],
                              //         detail: state.data['result'][index],
                              //       ),
                              //     );
                              //   },
                              // );
                            },
                          childCount: listDiscount.length,
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Center(
                          child: Text(
                            "Không có sản phẩm nào",
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
