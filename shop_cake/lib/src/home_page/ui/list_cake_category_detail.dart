import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/common/config/format_price.dart';
import 'package:shop_cake/common/config_read_file.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/src/detail_food/ui/detail_food_page.dart';
import 'package:shop_cake/src/home_page/bloc/list_category_detail_cubit.dart';
import 'package:shop_cake/src/list_food/bloc/list_food_cubit.dart';
import 'package:shop_cake/src/list_food/components/item_card.dart';

class ListCakeCategoryDetailPage extends StatefulWidget {
  final int? id;

  const ListCakeCategoryDetailPage({Key? key, this.id}) : super(key: key);

  @override
  State<ListCakeCategoryDetailPage> createState() =>
      _ListCakeCategoryDetailPageState();
}

class _ListCakeCategoryDetailPageState
    extends State<ListCakeCategoryDetailPage> {
  final listCategoryDetail = ListCategoryDetailCubit();
  final listFoodCubit = ListFoodCubit();

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  Future<void> _refresh() async {
    listCategoryDetail.listCategoryDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => listCategoryDetail,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kMainWhiteColor,
          elevation: 0,
          title: Text(
            "Sản phẩm",
            style: GoogleFonts.roboto(
              color: kMainDarkColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 12),
                  BlocBuilder<ListCategoryDetailCubit, ListCategoryDetailState>(
                    builder: (context, state) {
                      if (state is ListCategoryDetailLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: kMainColor,
                          ),
                        );
                      } else if (state is ListCategoryDetailSuccess &&
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
                                (context, index) =>
                                ItemCard(
                                  isPromotion: true,
                                  imageUrl: ReadFile.readFile(
                                      state.data['data'][index]['image']),
                                  title: state.data['data'][index]['name'],
                                  price: FormatPrice.formatVND(
                                      DiscountCake.discountCake(
                                          0.0,
                                          state.data['data'][index]['price'])),
                                  addToCart: () {
                                    listFoodCubit.addFoodToOrder(
                                      context,
                                      cakeId: state.data['data'][index]['id'],
                                      quantity:
                                      state.data['data'][index]['quantity'] ?? 1,
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
                                ),
                            childCount: state.data['data'].length > 4
                                ? 4
                                : state.data['data'].length ?? 0,
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
