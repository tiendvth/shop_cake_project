import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/common/config/format_price.dart';
import 'package:shop_cake/common/config/format_text_to_number.dart';
import 'package:shop_cake/common/config_read_file.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/constants/font_size/font_size.dart';
import 'package:shop_cake/src/detail_my_order/bloc/detail_my_order_cubit.dart';
import 'package:shop_cake/utils/utils.dart';
import 'package:shop_cake/widgets/space_extention.dart';
import '../../cart_page/componenst/cart_item.dart';

class DetailMyOrder extends StatefulWidget {
  final id;

  const DetailMyOrder({Key? key, this.id}) : super(key: key);

  @override
  State<DetailMyOrder> createState() => _DetailMyOrderState();
}

class _DetailMyOrderState extends State<DetailMyOrder> {
  bool isShowButton = true;

  @override
  Widget build(BuildContext context) {
    final detailMyOrderCubit = DetailMyOrderCubit(widget.id);
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => detailMyOrderCubit,
        child: BlocBuilder<DetailMyOrderCubit, DetailMyOrderState>(
          builder: (context, state) {
            if (state is DetailMyOrderSuccess) {
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
                            padding: EdgeInsets.fromLTRB(
                                20, AppBar().preferredSize.height + 15, 24, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Chi tiết đơn hàng',
                                  style: GoogleFonts.roboto(
                                      fontSize: FontSize.fontSize_18,
                                      fontWeight: FontWeight.w500,
                                      color: kMainDarkColor),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Đóng',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: kMainDarkColor),
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
                                color: kMainDarkGreyColor.withOpacity(0.2),
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
                                      '${FormatTextToNumber().formatPositiveNumber(money: state.totalPrice)}đ',
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
                                      // '${FormatTextToNumber().formatPositiveNumber(money: state.totalPrice)}đ',
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
                                      '${FormatTextToNumber().formatPositiveNumber(money: state.totalPrice)}đ',
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
                    ],
                  ),
                  20.spaceHeight,
                  // Align(
                  //   alignment: Alignment.topLeft,
                  //   child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(24, 40, 24, 15),
                  //     child: Row(
                  //       children: [
                  //         CText(
                  //           text: 'Tổng danh sách món',
                  //           fontSize: FontSize.fontSize_20,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //         // CText(
                  //         //   text: '  (${state.status ?? ''})',
                  //         //   fontSize: FontSize.fontSize_16,
                  //         //   fontWeight: FontWeight.w500,
                  //         //   textColor: FontColor.colorEC222D,
                  //         // ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: state.data.isNotEmpty
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    CartItem(
                                      quantity: state.data[index]['quantity'],
                                      name: state.data[index]['nameCake'],
                                      price: FormatPrice.formatVND(
                                          state.data[index]['price']),
                                      imageUrl: ReadFile.readFile(
                                          state.data[index]['image']),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                );
                              },
                              itemCount: state.data.length ?? 0,
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
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 15),
                      //   child: TextFormField(
                      //     decoration: InputDecoration(
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(4),
                      //       ),
                      //       hintText: 'Lí do hủy đơn',
                      //     ),
                      //     maxLines: 3,
                      //     controller: detailMyOrderCubit.cenCelController,
                      //   ),
                      // ),
                      if (state.status == 1)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: MaterialButton(
                            height: 40,
                            minWidth: MediaQuery.of(context).size.width,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                            animationDuration: const Duration(milliseconds: 200),
                            color: FontColor.colorEC222D.withOpacity(0.7),
                            onPressed: () {
                              showDialogNote(
                                context,
                                checkBack: false,
                                onConfirm: () async {
                                 await detailMyOrderCubit.callApiCanCel(context);
                                },
                              );
                              // if (detailMyOrderCubit
                              //     .cenCelController.text.isEmpty) {
                              //   showDialogNote(
                              //       context, 'Lí do hủy không thể để trống',
                              //       checkBack: false);
                              //   return;
                              // }
                              // detailMyOrderCubit.callApiCanCel(context);

                              // showDialogConfirm(
                              //     context, 'Bạn chắc chắnn muốn hủy đơn', () {
                              //   detailMyOrderCubit.callApiCanCel(context);
                              // });
                            },
                            child: Text(
                              'Huỷ đơn hàng',
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      if (state.status == 2)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: MaterialButton(
                            height: 40,
                            minWidth: MediaQuery.of(context).size.width,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                            animationDuration: const Duration(milliseconds: 200),
                            color: FontColor.colorEC222D.withOpacity(0.7),
                            onPressed: () {
                              showDialogNote(
                                context,
                                checkBack: false,
                                onConfirm: () async  {
                                 await detailMyOrderCubit.callApiCanCel(context);
                                },
                              );
                              // if (detailMyOrderCubit
                              //     .cenCelController.text.isEmpty) {
                              //   showDialogNote(
                              //       context, 'Lí do hủy không thể để trống',
                              //       checkBack: false);
                              //   return;
                              // }
                              // detailMyOrderCubit.callApiCanCel(context);

                              // showDialogConfirm(
                              //     context, 'Bạn chắc chắnn muốn hủy đơn', () {
                              //   detailMyOrderCubit.callApiCanCel(context);
                              // });
                            },
                            child: Text(
                              'Huỷ đơn hàng',
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      if (state.status == 3)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: MaterialButton(
                            height: 40,
                            minWidth: MediaQuery.of(context).size.width,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            animationDuration: const Duration(milliseconds: 200),
                            elevation: 0,
                            color: kMainGreenColor,
                            onPressed: () {
                              // if (detailMyOrderCubit
                              //     .cenCelController.text.isEmpty) {
                              //   showDialogMessage(
                              //       context, 'Lí do hủy không thể để trống',
                              //       checkBack: false);
                              //   return;
                              // }
                              // detailMyOrderCubit.callApiCanCel(context);
                              showDialogConfirm(
                                  context, 'Bạn đã nhận hàng?', () {
                                detailMyOrderCubit.callApiConfirm(context);
                              });
                            },
                            child: Text(
                              'Đã nhận hàng',
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      if (state.status == 4)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: MaterialButton(
                                  height: 40,
                                  minWidth: MediaQuery.of(context).size.width,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  animationDuration: const Duration(milliseconds: 200),
                                  elevation: 0,
                                  color: FontColor.colorF9A825.withOpacity(0.5),
                                  onPressed: () {
                                    // if (detailMyOrderCubit
                                    //     .cenCelController.text.isEmpty) {
                                    //   showDialogMessage(
                                    //       context, 'Lí do hủy không thể để trống',
                                    //       checkBack: false);
                                    //   return;
                                    // }
                                    // detailMyOrderCubit.callApiCanCel(context);
                                    // showDialogConfirm(
                                    //     context, 'Bạn đã nhận hàng?', () {
                                    //   detailMyOrderCubit.callApiConfirm(context);
                                    // });
                                  },
                                  child: Text(
                                    'Đánh giá',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(

                                width: 10,
                              ),
                              Expanded(
                                child: MaterialButton(
                                  height: 40,
                                  minWidth: MediaQuery.of(context).size.width,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  animationDuration: const Duration(milliseconds: 200),
                                  elevation: 0,
                                  color: FontColor.colorEC222D.withOpacity(0.7),
                                  onPressed: () {
                                    // if (detailMyOrderCubit
                                    //     .cenCelController.text.isEmpty) {
                                    //   showDialogMessage(
                                    //       context, 'Lí do hủy không thể để trống',
                                    //       checkBack: false);
                                    //   return;
                                    // }
                                    // detailMyOrderCubit.callApiCanCel(context);
                                    // showDialogConfirm(
                                    //     context, 'Bạn đã nhận hàng?', () {
                                    //   detailMyOrderCubit.callApiConfirm(context);
                                    // });
                                  },
                                  child: Text(
                                    'Mua lại',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (state.status == 5)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: MaterialButton(
                            height: 40,
                            minWidth: MediaQuery.of(context).size.width,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            animationDuration: const Duration(milliseconds: 200),
                            elevation: 0,
                            color: kMainRedColor.withOpacity(0.6),
                            onPressed: () {
                              // if (detailMyOrderCubit
                              //     .cenCelController.text.isEmpty) {
                              //   showDialogMessage(
                              //       context, 'Lí do hủy không thể để trống',
                              //       checkBack: false);
                              //   return;
                              // }
                              // detailMyOrderCubit.callApiCanCel(context);
                              // showDialogConfirm(
                              //     context, 'Bạn đã nhận hàng?', () {
                              //   detailMyOrderCubit.callApiConfirm(context);
                              // });
                            },
                            child: Text(
                              'Mua lại',
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ],
              );
            } else if (state is DetailMyOrderFailure) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(
                      fontSize: FontSize.fontSize_16,
                      color: FontColor.color212121),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
