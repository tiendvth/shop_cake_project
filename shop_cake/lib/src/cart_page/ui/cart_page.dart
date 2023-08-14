import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/common/config/format_price.dart';
import 'package:shop_cake/common/config_read_file.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/cart_page/bloc/list_card_bloc/list_card_cubit.dart';
import 'package:shop_cake/src/cart_page/componenst/appbar_cart_widget.dart';
import 'package:shop_cake/src/cart_page/componenst/cart_item.dart';
import 'package:shop_cake/src/cart_page/repository/cart_repository.dart';
import 'package:shop_cake/src/detail_food/bloc/counter_bloc/count_dish_cubit.dart';
import 'package:shop_cake/src/payment/ui/payment_page.dart';
import 'package:shop_cake/utils/utils.dart';
import 'package:shop_cake/widgets/c_image.dart';
import 'package:shop_cake/widgets/space_extention.dart';

class CartPage extends StatefulWidget {
  final bool? isShowIconBack;

  const CartPage({Key? key, this.isShowIconBack}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final listCardCubit = ListCardCubit(CartRepositoryImpl(apiProvider));
  final CountDishCubit _countDishCubit = CountDishCubit();

  @override
  void initState() {
    super.initState();
    listCardCubit.getListCart();
  }

  void updateCartItemQuantity(String? shopCartId, int quantity) async {
    await listCardCubit.addFood(
      context,
      shopCartId,
      quantity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => listCardCubit,
        ),
        BlocProvider(
          create: (_) => _countDishCubit,
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          top: false,
          bottom: true,
          child: BlocBuilder<ListCardCubit, ListCardState>(
            builder: (context, stateListCake) {
              if (stateListCake is ListCardSuccess) {
                print('stateListCake ${stateListCake.total}');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 180,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                            gradient: kBgMenu,
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(24,
                                  AppBar().preferredSize.height + 15, 24, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (widget.isShowIconBack == true) ...[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: kMainRedColor.withOpacity(0.6),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Giỏ hàng",
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                            color: kMainDarkColor,
                                          ),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                  if (widget.isShowIconBack == false) ...[
                                    Expanded(
                                      child: Text(
                                        "Giỏ hàng",
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: kMainDarkColor,
                                          ),
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                  InkWell(
                                    onTap: () {},
                                    child: const CImage(
                                      assetsPath: Assets.icNotification,
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              24, AppBar().preferredSize.height + 55, 24, 0),
                          child: Container(
                            // height: 125,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FontColor.colorFFFFFF,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: kMainDarkGreyColor.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Giá tiền',
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: k514D56,
                                      ),
                                    ),
                                    Text(
                                      // text: '${state.totalPrice}',
                                      FormatPrice.formatVND(
                                          stateListCake.total),
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: k514D56,
                                      ),
                                    ),
                                  ],
                                ),
                                5.spaceHeight,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      // text: '${state.totalPrice}',
                                      'Phí giao hàng',
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: k514D56,
                                      ),
                                    ),
                                    Text(
                                      // text: '${state.totalPrice}',
                                      '0 đ',
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: k514D56,
                                      ),
                                    ),
                                  ],
                                ),
                                5.spaceHeight,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      // text: '${state.totalPrice}',
                                      'Phí dich vụ khác',
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: k514D56,
                                      ),
                                    ),
                                    Text(
                                      // text: '${state.totalPrice}',
                                      '0 đ',
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: k514D56,
                                      ),
                                    ),
                                  ],
                                ),
                                10.spaceHeight,
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: FontColor.colorBorder,
                                ),
                                10.spaceHeight,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      // text: '${state.totalPrice}',
                                      'Tổng tiền',
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: kMainRedColor,
                                      ),
                                    ),
                                    Text(
                                      FormatPrice.formatVND(
                                          stateListCake.total),
                                      // '0đ',
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: kMainRedColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    20.spaceHeight,
                    Expanded(
                      child: SingleChildScrollView(
                        child: stateListCake.data.isNotEmpty ||
                                listCardCubit.datas.isNotEmpty
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                itemBuilder: (context, index) {
                                  // print(state.data[index]['quantity']);
                                  return Column(
                                    children: [
                                      CartItem(
                                        isShowQuantity: true,
                                        isShowButton: true,
                                        onTapRemove: () {
                                          listCardCubit.removeFood(
                                              context,
                                              stateListCake.data[index]
                                                  ['shoppingCartTmtId']);
                                        },
                                        quantity: stateListCake.data[index]
                                            ['quantityShoppingCartTmt'],
                                        name: stateListCake.data[index]
                                            ['nameCake'],
                                        price: FormatPrice.formatVND(
                                            stateListCake.data[index]
                                                ['priceCake']),
                                        imageUrl: ReadFile.readFile(
                                            stateListCake.data[index]
                                                ['imageCake']),
                                        onTapAdd: () {
                                          final count =
                                              stateListCake.data[index]
                                                  ['quantityShoppingCartTmt'];
                                          final quantity = count + 1;
                                          listCardCubit.addFood(
                                              context,
                                              // state.data[index]['id'],
                                              stateListCake.data[index]
                                                  ['shoppingCartTmtId'],
                                              quantity);
                                        },
                                        onTapMinus: () async {
                                          final count =
                                              stateListCake.data[index]
                                                  ['quantityShoppingCartTmt'];
                                          final quantity = count - 1;
                                          if (quantity == 0) {
                                            listCardCubit.removeFood(
                                                context,
                                                stateListCake.data[index]
                                                    ['shoppingCartTmtId']);
                                          } else {
                                            listCardCubit.addFood(
                                                context,
                                                // state.data[index]['id'],
                                                stateListCake.data[index]
                                                    ['shoppingCartTmtId'],
                                                quantity);
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                    ],
                                  );
                                },
                                itemCount: stateListCake.data.length ?? 0,
                                shrinkWrap: true,
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    top: 100, right: 16, left: 16),
                                child: Center(
                                  child: Text(
                                    'Không có sản phẩm nào trong giỏ hàng',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: k9B9B9B,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: InkWell(
                        onTap: () {
                          if (listCardCubit.datas.length > 0 &&
                              listCardCubit.datas != null &&
                              listCardCubit.datas.isNotEmpty) {
                            NavigatorManager.pushFullScreen(context,
                                PaymentPage(
                              callback: () async {
                                await listCardCubit.getListCart();
                                // listCardCubit.datas.clear();
                              },
                            )).then((value) {
                              listCardCubit.datas.clear();
                            });
                          } else {
                            showToast(
                              'Không có sản phẩm nào trong giỏ hàng',
                            );
                          }
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: kMainRedColor.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Mua hàng',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (stateListCake is ListCardLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: kMainColor,
                  ),
                );
              } else if (stateListCake is ListCardFailure) {
                return const AppbarCartWidget();
              } else {
                return const AppbarCartWidget();
              }
            },
          ),
        ),
        // floatingActionButton: Container(
        //   margin: const EdgeInsets.only(bottom: 15),
        //   child: FloatingActionButton(
        //     backgroundColor: Colors.pink,
        //     child: const Icon(
        //       Icons.add_shopping_cart,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {
        //       if (listCardCubit.datas.length > 0 && listCardCubit.datas != null &&
        //           listCardCubit.datas.isNotEmpty) {
        //         NavigatorManager.pushFullScreen(context, PaymentPage(
        //           callback: () async {
        //             await listCardCubit.getListCart();
        //             listCardCubit.datas.clear();
        //           },
        //         )).then((value) {
        //           listCardCubit.datas.clear();
        //         });
        //       }
        //     },
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}
