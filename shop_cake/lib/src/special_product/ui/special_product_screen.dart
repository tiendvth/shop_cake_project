import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/common/config/format_price.dart';
import 'package:shop_cake/common/config_read_file.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/src/detail_food/ui/detail_food_page.dart';
import 'package:shop_cake/src/home_page/bloc/list_special_cubit.dart';
import 'package:shop_cake/src/list_food/bloc/list_food_cubit.dart';
import 'package:shop_cake/src/list_food/components/item_card.dart';

class SpecialProductScreen extends StatefulWidget {
  const SpecialProductScreen({Key? key}) : super(key: key);

  @override
  State<SpecialProductScreen> createState() => _SpecialProductScreenState();
}

class _SpecialProductScreenState extends State<SpecialProductScreen> {
  final ListSpecialCubit listSpecialCubit = ListSpecialCubit();
  final ListFoodCubit listFoodCubit = ListFoodCubit();

  @override
  initState() {
    _refresh();
    super.initState();
  }

  Future<void> _refresh() async {
    listSpecialCubit.getBySpecial();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => listSpecialCubit,
        ),
        BlocProvider(
          create: (context) => listFoodCubit,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kMainWhiteColor,
          elevation: 0,
          title: Text(
            "Sản phẩm đặc biệt",
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
                  BlocBuilder<ListSpecialCubit, ListSpecialState>(
                    builder: (context, stateSpecial) {
                      if (stateSpecial is ListSpecialLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (stateSpecial is ListSpecialFailure) {
                        return Center(
                          child: Text(
                            'lỗi',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        );
                      } else if (stateSpecial is ListSpecialSuccess) {
                        if (
                            stateSpecial.data['data'] != null) {
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
                                    // isPromotion: true,
                                    imageUrl: ReadFile.readFile(
                                        stateSpecial
                                            .data['data'][index]['image']),
                                    title: stateSpecial
                                        .data['data'][index]['name'],
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
                                        quantity: stateSpecial
                                            .data['data'][index]
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
                                            detail: stateSpecial
                                                .data['data'][index],
                                          ));
                                    },
                                  ),
                              childCount: stateSpecial.data['data'].length,
                            ),
                          );
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
                      }else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: kMainColor,
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
