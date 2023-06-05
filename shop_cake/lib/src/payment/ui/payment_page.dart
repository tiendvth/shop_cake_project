import 'package:common/common.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/constants/font_size/font_size.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/payment/bloc/payment_cubit.dart';
import 'package:shop_cake/src/payment/repository/repository.dart';
import 'package:shop_cake/validation/validation.dart';
import 'package:shop_cake/widgets/c_button.dart';
import 'package:shop_cake/widgets/c_text.dart';
import 'package:shop_cake/widgets/space_extention.dart';

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
            builder: (context, state) {
              if (state is PaymentSuccess) {
                return Column(
                  children: [
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
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
                                            24,
                                            AppBar().preferredSize.height + 15,
                                            24,
                                            0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CText(
                                              text: 'Thanh toán',
                                              textColor: FontColor.colorFFFFFF,
                                              fontWeight: FontWeight.w600,
                                              fontSize: FontSize.fontSize_30,
                                            ),
                                            TextButton(
                                              onPressed: (){
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Đóng',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white
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
                                        24,
                                        AppBar().preferredSize.height + 90,
                                        24,
                                        0),
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
                                            offset: const Offset(0,
                                                3), // changes position of shadow
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CText(
                                                  text: 'Giá tiền',
                                                  fontSize:
                                                      FontSize.fontSize_16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                CText(
                                                  text: '${state.totalPrice}',
                                                  fontSize:
                                                      FontSize.fontSize_16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ],
                                            ),
                                            5.spaceHeight,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CText(
                                                  text: 'Phí giao hàng',
                                                  fontSize:
                                                      FontSize.fontSize_16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                CText(
                                                  text: '0',
                                                  fontSize:
                                                      FontSize.fontSize_16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ],
                                            ),
                                            5.spaceHeight,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CText(
                                                  text:
                                                      'Phí dịch vụ & phí khác',
                                                  fontSize:
                                                      FontSize.fontSize_16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                CText(
                                                  text: '0',
                                                  fontSize:
                                                      FontSize.fontSize_16,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CText(
                                                  text: 'Tổng thanh toán',
                                                  fontSize:
                                                      FontSize.fontSize_18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                CText(
                                                  text: '${state.totalPrice} đ',
                                                  fontSize:
                                                      FontSize.fontSize_18,
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
                              childCount: 1,
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        24, 40, 24, 15),
                                    child: CText(
                                      text: 'Tổng danh sách món',
                                      fontSize: FontSize.fontSize_20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              },
                              childCount: 1,
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 90,
                                              height: 90,
                                              child: Image.network(
                                                '${state.datas[index]['images'] ?? 'https://img.freepik.com/free-vector/thai-cuisine-food-flat-illustration_1284-74042.jpg?w=826&t=st=1662447770~exp=1662448370~hmac=d1eb58a73a830be233671c2c08232da012f7faca37554705b8971f4cb723fffa'}',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            8.spaceWidth,
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CText(
                                                      text:
                                                          '${state.datas[index]['name'] ?? 'vi cá mập'}',

                                                      fontSize:
                                                          FontSize.fontSize_17,
                                                      lineSpacing: 1.2,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                    5.spaceHeight,
                                                    Row(
                                                      children: [
                                                        const CText(
                                                          text: 'Tổng số:',
                                                        ),
                                                        CText(
                                                          text:
                                                              '${state.datas[index]['quantity'] ?? 0}',
                                                        )
                                                      ],
                                                    ),
                                                    5.spaceHeight,
                                                    Row(
                                                      children: [
                                                        CText(
                                                          text: 'Đơn giá:',
                                                          fontSize:
                                                              FontSize.fontSize_17,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          textColor:
                                                              FontColor.colorEC222D,
                                                        ),
                                                        CText(
                                                          text:
                                                              '${Validation.oCcy.format(state.datas[index]['unitPrice'] ?? 0)} đ',
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              childCount: state.datas.length,
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        24, 10, 24, 10),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 10),
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
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        value: state.typeShip,
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
                                );
                              },
                              childCount: 1,
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          24, 10, 24, 10),
                                      child: TextFormField(
                                        controller: paymentCubit.noteController,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            hintText: 'Nhập ghi chú'),
                                      )),
                                );
                              },
                              childCount: 1,
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Visibility(
                                    visible: state.typeShip == 'SHIP',
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                24, 10, 24, 10),
                                            child: TextFormField(
                                              controller:
                                                  paymentCubit.nameController,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  hintText: 'Nhập tên của bạn'),
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              24, 10, 24, 10),
                                          child: TextFormField(
                                            controller:
                                                paymentCubit.phoneController,
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
                                              controller: paymentCubit
                                                  .addressController,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  hintText: 'Nhập địa chỉ'),
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                      child: CButton(
                        width: double.infinity,
                        height: 44,
                        bgColor: FontColor.colorFF3366,
                        title: 'Thanh toán',
                        fontSize: FontSize.fontSize_16,
                        fontWeight: FontWeight.w600,
                        fontColor: FontColor.colorFFFFFF,
                        onPressed: () {
                          paymentCubit.callApiPayment(context);
                        },
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
