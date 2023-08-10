import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/common/config/string_service.dart';
import 'package:shop_cake/common/config_read_file.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/src/detail_food/ui/detail_food_page.dart';
import 'package:shop_cake/src/home_page/bloc/home_cubit.dart';
import 'package:shop_cake/src/home_page/bloc/list_special_cubit.dart';
import 'package:shop_cake/src/home_page/components/body.dart';
import 'package:shop_cake/src/home_page/components/categorries.dart';
import 'package:shop_cake/src/home_page/components/upper_body.dart';
import 'package:shop_cake/src/home_page/ui/list_cake_category_detail.dart';
import 'package:shop_cake/src/list_food/bloc/category_cubit.dart';
import 'package:shop_cake/src/list_food/bloc/list_food_cubit.dart';
import 'package:shop_cake/src/list_food/bloc/list_price_filter_cubit.dart';
import 'package:shop_cake/src/list_food/components/item_card.dart';
import 'package:shop_cake/src/list_food/ui/list_promotion_screen.dart';
import 'package:shop_cake/src/special_product/ui/special_product_screen.dart';

import '../../../common/config/format_price.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ListFoodCubit listFoodCubit = ListFoodCubit();
  final CategoryCubit categoryCubit = CategoryCubit();
  final HomeCubit homeCubit = HomeCubit();
  final ListSpecialCubit listSpecialCubit = ListSpecialCubit();
  final ListPriceFilterCubit listPriceFilterCubit = ListPriceFilterCubit();

  // final controller = GroupButtonController();
  final priceFilterCubit = ListPriceFilterCubit();
  int? priceFrom = 0;
  int? priceTo = 0;
  String? search = '';

  @override
  void initState() {
    super.initState();
    listFoodCubit.getListFood(search, priceFrom, priceTo);
    // listFoodCubit.getListFood(search, priceFrom, priceTo);
    categoryCubit.getCategory();
    listPriceFilterCubit.listPriceFilter();
    // homeCubit.getAllPromotions(search, priceFrom, priceTo);
    _refresh();
  }

  Future<void> _refresh() async {
    listFoodCubit.getListFood(
      listFoodCubit.searchController.text,
      priceFrom,
      priceTo,
    );
    priceFilterCubit.listPriceFilter();
    listSpecialCubit.getBySpecial();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => listFoodCubit,
        ),
        BlocProvider(
          create: (context) => categoryCubit,
        ),
        BlocProvider(create: (context) => listPriceFilterCubit),
        BlocProvider(create: (context) => homeCubit),
        BlocProvider(create: (context) => listSpecialCubit)
      ],
      child: Scaffold(
        backgroundColor: kBackground,
        body: Stack(
          children: [
            UpperBody(
              onChanged: (value) {
                setState(() {
                  listFoodCubit.getListFood(
                    value,
                    priceFrom,
                    priceTo,
                  );
                  listSpecialCubit.getBySpecial();
                });
              },
            ),
            // BlocBuilder<ListPriceFilterCubit, ListPriceFilterState>(
            //   builder: (context, statePrice) {
            //     if (statePrice is ListPriceFilterSuccess) {
            //       return UpperBody(
            //         onTap: () {
            //           showDialog(
            //             context: context,
            //             builder: (context) {
            //               return DialogFilter(
            //                 child: Container(
            //                   height: 380,
            //                   decoration: const BoxDecoration(
            //                     color: Colors.white,
            //                   ),
            //                   child: GroupButton(
            //                     controller: controller,
            //                     buttons: statePrice.data
            //                         .map((e) =>
            //                             '${FormatPrice.formatPriceToInt(e.priceFrom)} - ${FormatPrice.formatPriceToInt(e.priceTo)}')
            //                         .toList(),
            //                     onSelected: (index, value, isSelected) {
            //                       priceFrom = statePrice.data[value].priceFrom;
            //                       priceTo = statePrice.data[value].priceTo;
            //                     },
            //                     options: GroupButtonOptions(
            //                       spacing: 8,
            //                       unselectedTextStyle: GoogleFonts.roboto(
            //                         fontSize: 14,
            //                         fontWeight: FontWeight.w400,
            //                         color: Colors.black,
            //                       ),
            //                       groupRunAlignment: GroupRunAlignment.start,
            //                       unselectedColor: Colors.white,
            //                       selectedColor: kMainDarkColor,
            //                       selectedTextStyle: GoogleFonts.roboto(
            //                         fontSize: 14,
            //                         fontWeight: FontWeight.w400,
            //                         color: Colors.white,
            //                       ),
            //                       borderRadius: BorderRadius.circular(8),
            //                       textAlign: TextAlign.center,
            //                       buttonWidth:
            //                           MediaQuery.of(context).size.width / 2 -
            //                               56,
            //                       runSpacing: 8,
            //                       direction: Axis.horizontal,
            //                     ),
            //                   ),
            //                 ),
            //                 onTap: () {
            //                   print('tap popup');
            //                   listFoodCubit.getListFood(
            //                     search,
            //                     priceFrom,
            //                     priceTo,
            //                   );
            //                   Navigator.pop(context);
            //                 },
            //               );
            //             },
            //           );
            //         },
            //       );
            //     } else {
            //       return const SizedBox();
            //     }
            //   },
            // ),
            RefreshIndicator(
              color: kMainDarkColor,
              onRefresh: _refresh,
              child: Body(
                childCategories: BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                    if (state is CategorySuccess) {
                      return state.data['result'].length > 0
                          ? SizedBox(
                              height: 40,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: state.data['result'].length,
                                itemBuilder: (context, index) {
                                  return Categories(
                                    title: state.data['result'][index]['name'],
                                    onTap: () {
                                      NavigatorManager.pushFullScreen(
                                        context,
                                        ListCakeCategoryDetailPage(
                                          id: state.data['result'][index]['id'],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            )
                          : const SizedBox();
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Sản phẩm khuyến mãi",
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            NavigatorManager.push(
                              context,
                              const ListPromotionScreen(),
                            );
                          },
                          child: Text(
                            "Xem thêm",
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
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
                              childCount: listDiscount.length > 4
                                  ? 4
                                  : listDiscount.length,
                            ),
                          );
                        }  else {
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
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Sản phẩm Đặc biệt",
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            NavigatorManager.push(
                              context,
                              const SpecialProductScreen(),
                            );
                          },
                          child: Text(
                            "Xem thêm",
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    BlocBuilder<ListSpecialCubit, ListSpecialState>(
                      builder: (context, stateSpecial) {
                        if (stateSpecial is ListSpecialSuccess) {
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
                              (context, index) => ItemCard(
                                // isPromotion: true,
                                imageUrl: ReadFile.readFile(
                                    stateSpecial.data['data'][index]['image']),
                                title: stateSpecial.data['data'][index]['name'],
                                price: FormatPrice.formatVND(
                                    DiscountCake.discountCake(
                                        0.0,
                                        stateSpecial.data['data'][index]
                                            ['price'])),
                                addToCart: () {
                                  listFoodCubit.addFoodToOrder(
                                    context,
                                    cakeId: stateSpecial.data['data'][index]
                                        ['id'],
                                    quantity: stateSpecial.data['data'][index]
                                            ['quantity'] ??
                                        1,
                                  );
                                },
                                onTap: () {
                                  NavigatorManager.pushFullScreen(
                                      context,
                                      DetailFood(
                                        id: stateSpecial.data['data'][index]
                                                ['id'] ??
                                            '',
                                        detail: stateSpecial.data['data']
                                            [index],
                                      ));
                                },
                              ),
                              childCount: stateSpecial.data['data'].length > 4
                                  ? 4
                                  : stateSpecial.data['data'].length ?? 0,
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
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
