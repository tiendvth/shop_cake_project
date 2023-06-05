import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/constants/font_size/font_size.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/cart_page/bloc/list_card_bloc/list_card_cubit.dart';
import 'package:shop_cake/src/cart_page/repository/cart_repository.dart';
import 'package:shop_cake/src/payment/ui/payment_page.dart';
import 'package:shop_cake/validation/validation.dart';
import 'package:shop_cake/widgets/c_text.dart';
import 'package:shop_cake/widgets/space_extention.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

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
            builder: (context, state) {
              if (state is ListCardSuccess) {
                return SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      Stack(children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                            color: FontColor.colorFF3366,
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(24,
                                  AppBar().preferredSize.height + 15, 24, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CText(
                                    text: 'Giỏ hàng',
                                    textColor: FontColor.colorFFFFFF,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.fontSize_30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              24, AppBar().preferredSize.height + 90, 24, 0),
                          child: Container(
                            height: 130,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FontColor.colorFFFFFF,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
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
                                            '${Validation.oCcy.format(state.totalPrice ?? 0)}',
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
                                            '${Validation.oCcy.format(state.totalPrice ?? 0)} đ',
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
                      ]),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 40, 24, 15),
                          child: CText(
                            text: 'Tổng danh sách món',
                            fontSize: FontSize.fontSize_20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          print(state.data[index]['quantity']);
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 110,
                                        height: 110,
                                        child: Image.network(
                                          '${state.data[index]['images'] ?? 'https://img.freepik.com/free-vector/thai-cuisine-food-flat-illustration_1284-74042.jpg?w=826&t=st=1662447770~exp=1662448370~hmac=d1eb58a73a830be233671c2c08232da012f7faca37554705b8971f4cb723fffa'}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      8.spaceWidth,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CText(
                                              text:
                                                  '${state.data[index]['name'] ?? 'vi cá mập'}',
                                              fontSize: FontSize.fontSize_16,
                                              fontWeight: FontWeight.w500,
                                              maxLine: 1,
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                            ),
                                            5.spaceHeight,
                                            Row(
                                              children: [
                                                CText(
                                                  text: 'Tổng số:',
                                                  fontSize:
                                                      FontSize.fontSize_12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 5),
                                                  child: CText(
                                                    text:
                                                        '${state.data[index]['quantity'] ?? 0}',
                                                    fontSize:
                                                        FontSize.fontSize_12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            5.spaceHeight,
                                            Row(
                                              children: [
                                                CText(
                                                  text: 'Đơn giá:',
                                                  fontSize:
                                                      FontSize.fontSize_14,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      FontColor.colorEC222D,
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 5),
                                                  child: CText(
                                                    text:
                                                        '${Validation.oCcy.format(state.data[index]['unitPrice'] ?? 0)} đ',
                                                    fontSize:
                                                        FontSize.fontSize_14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: 22,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: Colors.redAccent),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          final count =
                                                              state.data[index]
                                                                  ['quantity'];
                                                          final quantity =
                                                              count - 1;
                                                          if (quantity == 0) {
                                                            listCardCubit
                                                                .removeFood(
                                                                    context,
                                                                    state.data[
                                                                            index]
                                                                        ['id']);
                                                          } else {
                                                            listCardCubit.addFood(
                                                                context,
                                                                state.data[
                                                                        index]
                                                                    ['id'],
                                                                quantity);
                                                          }
                                                        },
                                                        icon: const Icon(
                                                          Icons.remove,
                                                          color: Colors.white,
                                                          size: 12,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          final count =
                                                              state.data[index]
                                                                  ['quantity'];
                                                          final quantity =
                                                              count + 1;
                                                          listCardCubit.addFood(
                                                              context,
                                                              state.data[index]
                                                                  ['id'],
                                                              quantity);
                                                        },
                                                        icon: const Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                          size: 12,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: state.data.length ?? 0,
                        shrinkWrap: true,
                      )
                    ],
                  ),
                );
              }
              return Stack(children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    color: FontColor.colorFF3366,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          24, AppBar().preferredSize.height + 15, 24, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CText(
                            text: 'Giỏ hàng',
                            textColor: FontColor.colorFFFFFF,
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.fontSize_30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      24, AppBar().preferredSize.height + 90, 24, 0),
                  child: Container(
                    height: 130,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FontColor.colorFFFFFF,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CText(
                                text: 'Giá tiền',
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
                          5.spaceHeight,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CText(
                                text: 'Tổng thanh toán',
                                fontSize: FontSize.fontSize_18,
                                fontWeight: FontWeight.w600,
                              ),
                              CText(
                                text: '0 đ',
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
              ]);
            },
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 15),
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
