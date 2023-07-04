import 'package:common/common.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/constants/font_size/font_size.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/cart_page/componenst/cart_item.dart';
import 'package:shop_cake/src/payment/bloc/payment_cubit.dart';
import 'package:shop_cake/src/payment/repository/repository.dart';
import 'package:shop_cake/widgets/c_button.dart';
import 'package:shop_cake/widgets/space_extention.dart';

import '../../../common/ config/format_price.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentCubit = PaymentCubit(PaymentRepositoryImpl(apiProvider));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: false,
        bottom: true,
        child: BlocProvider(
          create: (context) => paymentCubit,
          child: BlocBuilder<PaymentCubit, PaymentState>(
            builder: (context, statePayment) {
              if (statePayment is PaymentSuccess) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(children: [
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
                                AppBar().preferredSize.height + 0, 16, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Thanh toán',
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: kMainRedColor,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Đóng',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: kMainRedColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            24, AppBar().preferredSize.height + 65, 24, 0),
                        child: Container(
                          height: 120,
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
                                      '0đ',
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
                                      '0đ',
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
                                      '0đ',
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
                                      // text: '${state.totalPrice}',
                                      '0đ',
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
                      ),
                    ]),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Danh sách Đơn hàng',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: kMainBlackColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              itemBuilder: (context, index) {
                                // print(state.data[index]['quantity']);
                                return Column(
                                  children: [
                                    CartItem(
                                      quantity: statePayment.data[index]
                                      ['quantityShoppingCartTmt']
                                          .toString(),
                                      name: statePayment.data[index]['nameCake'],
                                      price: FormatPrice.formatVND(
                                          statePayment.data[index]['priceCake']),
                                      imageUrl: statePayment.data[index]
                                      ['imageCake'],
                                      onTapAdd: () {
                                        final count =
                                        statePayment.data[index]['quantity'];
                                        final quantity = count + 1;
                                        // listCardCubit.addFood(
                                        //     context,
                                        //     // state.data[index]['id'],
                                        //     1,
                                        //     quantity);
                                      },
                                      onTapMinus: () {
                                        final count =
                                        statePayment.data[index]['quantity'];
                                        final quantity = count - 1;
                                        if (quantity == 0) {
                                          // listCardCubit.removeFood(
                                          //     context,
                                          //     // state.data[index]['id']
                                          //     1);
                                        } else {
                                          // listCardCubit.addFood(
                                          //     context,
                                          //     statePayment.data[index]['quantity'],
                                          //     quantity);
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                );
                              },
                              itemCount: statePayment.data.length ?? 0,
                              shrinkWrap: true,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 4),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 7),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(width: 0.5)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: Text(
                                    'Select Item',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: paymentCubit.items
                                      .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                                      .toList(),
                                  value: paymentCubit.selectedValue,
                                  onChanged: (value) {
                                    paymentCubit.selectedValue =
                                    value as String;
                                    paymentCubit.updateTypeShip();
                                  },
                                  buttonHeight: 40,
                                  buttonWidth: double.infinity,
                                  itemHeight: 40,
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                child: TextFormField(
                                  controller: paymentCubit.noteController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      hintStyle: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: k9B9B9B,
                                      ),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      hintText: 'Nhập ghi chú'),
                                )),
                            Visibility(
                              visible: paymentCubit.selectedValue ==
                                  paymentCubit.items[1],
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      child: TextFormField(
                                        controller: paymentCubit.nameController,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            hintText: 'Nhập tên của bạn'),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 4),
                                    child: TextFormField(
                                      controller: paymentCubit.phoneController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                        hintText: 'Nhập số điện thoại',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          24, 10, 24, 10),
                                      child: TextFormField(
                                        controller:
                                        paymentCubit.addressController,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(12),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(12),
                                              borderSide: const BorderSide(
                                                  color: kMainRedColor),
                                            ),
                                            hintText: 'Nhập địa chỉ'),
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Column(
                        children: [
                          CButton(
                            width: double.infinity,
                            height: 44,
                            radius: 16,
                            bgColor: kMainRedColor.withOpacity(0.5),
                            borderColor: kMainRedColor,
                            title: 'Thanh toán',
                            fontSize: FontSize.fontSize_16,
                            fontWeight: FontWeight.w600,
                            fontColor: FontColor.colorFFFFFF,
                            onPressed: () {
                              paymentCubit.callApiPayment(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
