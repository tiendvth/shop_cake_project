import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/common/config/format_price.dart';
import 'package:shop_cake/common/config/string_service.dart';
import 'package:shop_cake/common/config_read_file.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/src/detail_food/ui/detail_food_page.dart';
import 'package:shop_cake/src/favourite/bloc/favourite_cubit.dart';
import 'package:shop_cake/src/list_food/bloc/list_food_cubit.dart';
import 'package:shop_cake/src/list_food/components/item_card.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final FavouriteCubit favouriteCubit = FavouriteCubit();
  final listFoodCubit = ListFoodCubit();

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  Future<void> _refresh() async {
    favouriteCubit.getFavourite();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => favouriteCubit,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kMainWhiteColor,
          elevation: 0,
          title: Text(
            "Sản phẩm yêu thích",
            style: GoogleFonts.roboto(
              color: kMainDarkColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
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
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              gradient: kBgMenu,
            ),
          ),
        ),
        body: RefreshIndicator(
          color: kMainColor,
          onRefresh: _refresh,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Tất cả sản phẩm",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<FavouriteCubit, FavouriteState>(
                    builder: (context, state) {
                      if (state is FavouriteLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: kMainColor,
                          ),
                        );
                      } else if (state is FavouriteSuccess &&
                          state.data['data'] != null &&
                          state.data['data'].length > 0) {
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
                              if (state.data['data'][index]['discount'] ==
                                  null) {
                                return ItemCard(
                                  imageUrl: ReadFile.readFile(
                                      state.data['data'][index]['image']),
                                  title: state.data['data'][index]['name'],
                                  price: FormatPrice.formatVND(
                                      state.data['data'][index]['price']),
                                  addToCart: () {
                                    listFoodCubit.addFoodToOrder(
                                      context,
                                      cakeId: state.data['data'][index]['id'],
                                      quantity: state.data['data'][index]
                                              ['quantity'] ??
                                          1,
                                    );
                                  },
                                  isFav: true,
                                  onTapFav: () async {
                                    await favouriteCubit.removeFavourite(
                                      id: state.data['data'][index]['id'],
                                    );
                                    favouriteCubit.getFavourite();
                                  },
                                  onTap: () {
                                    NavigatorManager.pushFullScreen(
                                        context,
                                        DetailFood(
                                          id: state.data['data'][index]['id'] ??
                                              '',
                                          detail: state.data['data'][index],
                                        ));
                                  },
                                );
                              } else {
                                print(state.data['data'][index]['price']);
                                return ItemCard(
                                  isPromotion: true,
                                  isCheckShowPriceSale: true,
                                  promotionSale:
                                      'Sale ${StringService.formatDiscount(state.data['data'][index]['discount'] ?? 0.0)} %',
                                  imageUrl: ReadFile.readFile(
                                      state.data['data'][index]['image']),
                                  title: state.data['data'][index]['name'],
                                  price: FormatPrice.formatVND(
                                      state.data['data'][index]['price']),
                                  priceSale: FormatPrice.formatVND(
                                      DiscountCake.discountCake(
                                          state.data['data'][index]['discount'],
                                          state.data['data'][index]['price'])),
                                  isFav: true,
                                  onTapFav: () async {
                                   await favouriteCubit.removeFavourite(
                                      id: state.data['data'][index]['id'],
                                    );
                                    favouriteCubit.getFavourite();
                                  },
                                  addToCart: () {
                                    listFoodCubit.addFoodToOrder(
                                      context,
                                      cakeId: state.data['data'][index]['id'],
                                      quantity: state.data['data'][index]
                                              ['quantity'] ??
                                          1,
                                    );
                                  },
                                  onTap: () {
                                    NavigatorManager.pushFullScreen(
                                        context,
                                        DetailFood(
                                          id: state.data['data'][index]['id'] ??
                                              '',
                                          detail: state.data['data'][index],
                                        ));
                                  },
                                );
                              }
                            },
                            childCount: state.data['data'].length,
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 64),
                          child: Center(
                            child: Text(
                              "Danh mục sản phẩm trống",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
