import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/common/%20config/format_price.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/constants/font_size/font_size.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/cart_page/bloc/list_card_bloc/list_card_cubit.dart';
import 'package:shop_cake/src/cart_page/componenst/appbar_cart_widget.dart';
import 'package:shop_cake/src/cart_page/componenst/cart_item.dart';
import 'package:shop_cake/src/cart_page/repository/cart_repository.dart';
import 'package:shop_cake/src/payment/ui/payment_page.dart';
import 'package:shop_cake/widgets/c_image.dart';
import 'package:shop_cake/widgets/c_text.dart';
import 'package:shop_cake/widgets/space_extention.dart';

class CartPage extends StatefulWidget {
  final bool? isShowIconBack;
  const CartPage({Key? key, this.isShowIconBack}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final listCardCubit = ListCardCubit(CartRepositoryImpl(apiProvider));
    return BlocProvider(
      create: (context) => listCardCubit,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          top: false,
          bottom: true,
          child: BlocBuilder<ListCardCubit, ListCardState>(
            builder: (context, stateListCake) {
              if (stateListCake is ListCardSuccess) {
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
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
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
                                            fontSize: 20,
                                            color: kMainDarkColor,
                                          ),
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                  const CImage(
                                    assetsPath: Assets.icNotification,
                                    height: 24,
                                    width: 24,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              24, AppBar().preferredSize.height + 70, 24, 0),
                          child: Container(
                            height: 130,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FontColor.colorFFFFFF,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CText(
                                        text: 'Giá tiền',
                                        fontSize: FontSize.fontSize_16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      CText(
                                        text:
                                            // '${Validation.oCcy.format(state.totalPrice ?? 0)}',
                                            '0',
                                        fontSize: FontSize.fontSize_16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  5.spaceHeight,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CText(
                                        text: 'Phí giao hàng',
                                        fontSize: FontSize.fontSize_14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      CText(
                                        text: '0',
                                        fontSize: FontSize.fontSize_16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  5.spaceHeight,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CText(
                                        text: 'Phí dịch vụ & phí khác',
                                        fontSize: FontSize.fontSize_16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      CText(
                                        text: '0',
                                        fontSize: FontSize.fontSize_16,
                                        fontWeight: FontWeight.w500,
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
                                      CText(
                                        text: 'Tổng thanh toán',
                                        fontSize: FontSize.fontSize_18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      CText(
                                        text:
                                            // '${Validation.oCcy.format(state.totalPrice ?? 0)} đ',
                                            '0 đ',
                                        fontSize: FontSize.fontSize_18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    20.spaceHeight,
                    Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          itemBuilder: (context, index) {
                            // print(state.data[index]['quantity']);
                            return Column(
                              children: [
                                CartItem(
                                  quantity: stateListCake.data[index]
                                          ['quantityShoppingCartTmt']
                                      .toString(),
                                  name: stateListCake.data[index]['nameCake'],
                                  price: FormatPrice.formatVND(
                                      stateListCake.data[index]['priceCake']),
                                  imageUrl: stateListCake.data[index]
                                      ['imageCake'],
                                  onTapAdd: () {
                                    final count =
                                        stateListCake.data[index]['quantity'];
                                    final quantity = count + 1;
                                    listCardCubit.addFood(
                                        context,
                                        // state.data[index]['id'],
                                        1,
                                        quantity);
                                  },
                                  onTapMinus: () {
                                    final count =
                                        stateListCake.data[index]['quantity'];
                                    final quantity = count - 1;
                                    if (quantity == 0) {
                                      listCardCubit.removeFood(
                                          context,
                                          // state.data[index]['id']
                                          1);
                                    } else {
                                      listCardCubit.addFood(
                                          context,
                                          stateListCake.data[index]['quantity'],
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
                        ),
                      ),
                    ),
                  ],
                );
              } else if (stateListCake is ListCardLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (stateListCake is ListCardFailure) {
                return const AppbarCartWidget();
              } else {
                return const AppbarCartWidget();
              }
            },
          ),
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: FloatingActionButton(
            backgroundColor: Colors.pink,
            child: const Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              if (listCardCubit.datas.length > 0) {
                NavigatorManager.pushFullScreen(context, PaymentPage())
                    .then((value) {
                  listCardCubit.getListCart();
                });
              }
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}
