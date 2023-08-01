import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/common/%20config/format_text_to_number.dart';
import 'package:shop_cake/common/config_read_file.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/constants/font_size/font_size.dart';
import 'package:shop_cake/src/detail_my_order/bloc/detail_my_order_cubit.dart';
import 'package:shop_cake/widgets/c_text.dart';
import 'package:shop_cake/widgets/space_extention.dart';

import '../../../common/ config/format_price.dart';
import '../../cart_page/componenst/cart_item.dart';

class DetailMyOrder extends StatelessWidget {
  final id;

  const DetailMyOrder({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailMyOrderCubit = DetailMyOrderCubit(id);
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
                  Stack(children: [
                    Container(
                      width: double.infinity,
                      height: 230,
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
                              CText(
                                text: 'Chi tiết đơn hàng',
                                textColor: kMainDarkColor,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.fontSize_22,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Đóng',
                                  style: GoogleFonts.roboto(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: kMainDarkColor
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
                      ?ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        itemBuilder: (context, index) {
                          // return Align(
                          //   alignment: Alignment.topLeft,
                          //   child: Padding(
                          //     padding: const EdgeInsets.symmetric(horizontal: 24),
                          //     child: Card(
                          //       child: Padding(
                          //         padding: const EdgeInsets.only(
                          //           right: 10,
                          //         ),
                          //         child: Row(
                          //           children: [
                          //             SizedBox(
                          //               width: 110,
                          //               height: 110,
                          //               child: Image.network(
                          //                 // '${state.data[index]['images'] ??
                          //                     'https://img.freepik.com/free-vector/thai-cuisine-food-flat-illustration_1284-74042.jpg?w=826&t=st=1662447770~exp=1662448370~hmac=d1eb58a73a830be233671c2c08232da012f7faca37554705b8971f4cb723fffa',
                          //                 fit: BoxFit.cover,
                          //               ),
                          //             ),
                          //             8.spaceWidth,
                          //             // Expanded(
                          //             //   child: Column(
                          //             //     crossAxisAlignment:
                          //             //     CrossAxisAlignment.start,
                          //             //     children: [
                          //             //       CText(
                          //             //         text:
                          //             //         // '${state.data[index]['name'] ??
                          //             //         //     'vi cá mập'}',
                          //             //         'vi cá mập',
                          //             //         fontSize: FontSize.fontSize_16,
                          //             //         fontWeight: FontWeight.w500,
                          //             //         maxLine: 1,
                          //             //         textOverflow: TextOverflow.ellipsis,
                          //             //       ),
                          //             //       5.spaceHeight,
                          //             //       Row(
                          //             //         children: [
                          //             //           CText(
                          //             //             text: 'Tổng số:',
                          //             //             fontSize: FontSize.fontSize_12,
                          //             //             fontWeight: FontWeight.w400,
                          //             //           ),
                          //             //           Padding(
                          //             //             padding:
                          //             //             const EdgeInsets.only(left: 5),
                          //             //             child: CText(
                          //             //               text:
                          //             //               // '${state
                          //             //               //     .data[index]['quantity'] ??
                          //             //               //     0}',
                          //             //               '0',
                          //             //               fontSize:
                          //             //               FontSize.fontSize_12,
                          //             //               fontWeight: FontWeight.w400,
                          //             //             ),
                          //             //           ),
                          //             //         ],
                          //             //       ),
                          //             //       5.spaceHeight,
                          //             //       Row(
                          //             //         children: [
                          //             //           CText(
                          //             //             text: 'Đơn giá:',
                          //             //             fontSize: FontSize.fontSize_14,
                          //             //             fontWeight: FontWeight.w500,
                          //             //             textColor:
                          //             //             FontColor.colorEC222D,
                          //             //           ),
                          //             //           Padding(
                          //             //             padding:
                          //             //             const EdgeInsets.only(left: 5),
                          //             //             child: CText(
                          //             //               text:
                          //             //               // '${Validation.oCcy.format(
                          //             //               //     state
                          //             //               //         .data[index]['unitPrice'] ??
                          //             //               //         0)} đ',
                          //             //               '0 đ',
                          //             //               fontSize:
                          //             //               FontSize.fontSize_14,
                          //             //               fontWeight: FontWeight.w500,
                          //             //             ),
                          //             //           )
                          //             //         ],
                          //             //       ),
                          //             //     ],
                          //             //   ),
                          //             // )
                          //             Expanded(
                          //               child: SingleChildScrollView(
                          //                 child: state.data.isNotEmpty
                          //                     ? ListView.builder(
                          //                       physics: const NeverScrollableScrollPhysics(),
                          //                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          //                       itemBuilder: (context, index) {
                          //                         // print(state.data[index]['quantity']);
                          //                         return Column(
                          //                           children: [
                          //                             Slidable(
                          //                               endActionPane: ActionPane(
                          //                                 motion: const ScrollMotion(),
                          //                                 extentRatio: 0.5,
                          //                                 children: [
                          //                                 // SlidableAction(
                          //                                 //   onPressed: (BuildContext context) {
                          //                                 //         // listCardCubit.removeFood(context,
                          //                                 //         // stateListCake.data[index]['shoppingCartTmtId']);
                          //                                 //   },
                          //                                 //   backgroundColor: kMainRedColor
                          //                                 //       .withOpacity(0.6),
                          //                                 //   foregroundColor: Colors.white,
                          //                                 //   icon:
                          //                                 //   Icons.delete_forever_rounded,
                          //                                 //   label: 'Xóa',
                          //                                 //   borderRadius:
                          //                                 //   BorderRadius.circular(8),
                          //                                 // ),
                          //                                 // SlidableAction(
                          //                                 //   onPressed: null,
                          //                                 //   backgroundColor:
                          //                                 //   const Color(0xFF21B7CA),
                          //                                 //   foregroundColor: Colors.white,
                          //                                 //   icon: Icons.clear,
                          //                                 //   label: 'Đóng',
                          //                                 //   borderRadius:
                          //                                 //   BorderRadius.circular(8),
                          //                                 // ),
                          //                                 ],
                          //                               ),
                          //                               child: CartItem(
                          //                                 quantity: state.data[index]
                          //                                 ['quantityShoppingCartTmt'],
                          //                                 name: state.data[index]['nameCake'],
                          //                                 price: FormatPrice.formatVND(
                          //                                     state.data[index]['priceCake']),
                          //                                 imageUrl: state.data[index]
                          //                                 ['imageCake'],
                          //                                 // onTapAdd: () {
                          //                                 //   final count =
                          //                                 //   state.data[index]['quantity'];
                          //                                 //   final quantity = count + 1;
                          //                                 //   // listCardCubit.addFood(
                          //                                 //   //     context,
                          //                                 //   //     // state.data[index]['id'],
                          //                                 //   //     1,
                          //                                 //   //     quantity);
                          //                                 // },
                          //                                 // onTapMinus: () {
                          //                                 //   final count =
                          //                                 //   stateListCake.data[index]['quantity'];
                          //                                 //   final quantity = count - 1;
                          //                                 //   if (quantity == 0) {
                          //                                 //     listCardCubit.removeFood(
                          //                                 //         context,
                          //                                 //         // state.data[index]['id']
                          //                                 //         1);
                          //                                 //   } else {
                          //                                 //     listCardCubit.addFood(
                          //                                 //         context,
                          //                                 //         stateListCake.data[index]
                          //                                 //         ['quantity'],
                          //                                 //         quantity);
                          //                                 //   }
                          //                                 // },
                          //                               ),
                          //                             ),
                          //                           const SizedBox(
                          //                             height: 12,
                          //                         ),
                          //                       ],
                          //                     );
                          //                   },
                          //                   itemCount: state.data.length ?? 0,
                          //                   shrinkWrap: true,
                          //                 )
                          //                     : Padding(
                          //                   padding: const EdgeInsets.only(
                          //                       top: 100, right: 16, left: 16),
                          //                   child: Center(
                          //                     child: Text(
                          //                       'Không có sản phẩm nào trong giỏ hàng',
                          //                       style: GoogleFonts.roboto(
                          //                         fontSize: 16,
                          //                         fontWeight: FontWeight.w400,
                          //                         color: k9B9B9B,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // );
                          return Column(
                            children: [
                              Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  extentRatio: 0.5,
                                  children: [
                                    SlidableAction(
                                      onPressed:
                                          (BuildContext context) {
                                        // listCardCubit.removeFood(
                                        //     context,
                                        //     stateListCake.data[index]
                                        //     ['shoppingCartTmtId']);
                                      },
                                      backgroundColor: kMainRedColor
                                          .withOpacity(0.6),
                                      foregroundColor: Colors.white,
                                      icon:
                                      Icons.delete_forever_rounded,
                                      label: 'Xóa',
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                    SlidableAction(
                                      onPressed: null,
                                      backgroundColor:
                                      const Color(0xFF21B7CA),
                                      foregroundColor: Colors.white,
                                      icon: Icons.clear,
                                      label: 'Đóng',
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                  ],
                                ),
                                child: CartItem(
                                  quantity: state.data[index]
                                  ['quantity'],
                                  name: state.data[index]['nameCake'],
                                  price: FormatPrice.formatVND(
                                      state.data[index]['price']),
                                  imageUrl: ReadFile.readFile(
                                      state.data[index]
                                      ['image']),

                                  // onTapAdd: () {
                                    // final count =
                                    // stateListCake.data[index]['quantity'];
                                    // final quantity = count + 1;
                                    // listCardCubit.addFood(
                                    //     context,
                                    //     // state.data[index]['id'],
                                    //     1,
                                    //     quantity);
                                  // },
                                  // onTapMinus: () {
                                    // final count =
                                    // state.data[index]['quantity'];
                                    // final quantity = count - 1;
                                    // if (quantity == 0) {
                                    //   listCardCubit.removeFood(
                                    //       context,
                                    //       // state.data[index]['id']
                                    //       1);
                                    // } else {
                                    //   listCardCubit.addFood(
                                    //       context,
                                    //       stateListCake.data[index]
                                    //       ['quantity'],
                                    //       quantity);
                                    // }
                                  // },
                                ),
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
                  const SizedBox(height: 20,),
                  // if(state.status == 'PENDING')
                  //   Column(
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 15),
                  //         child: TextFormField(
                  //           decoration: InputDecoration(
                  //             border: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(4),
                  //             ),
                  //             hintText: 'Lí do hủy đơn',
                  //           ),
                  //           maxLines: 3,
                  //           controller: detailMyOrderCubit.cenCelController,
                  //         ),
                  //       ),
                  //       const SizedBox(height: 20,),
                  //       MaterialButton(
                  //         height: 50,
                  //         minWidth: MediaQuery.of(context).size.width - 30,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(4),
                  //         ),
                  //         color: Colors.redAccent,
                  //         onPressed: () {
                  //           if(detailMyOrderCubit.cenCelController.text.isEmpty){
                  //             showDialogMessage(context, 'Lí do hủy không thể để trống', checkBack: false);
                  //             return;
                  //           }
                  //           // detailMyOrderCubit.callApiCanCel(context);
                  //           showDialogConfirm(context,'Bạn chắc chắnn muốn hủy đơn', (){
                  //             detailMyOrderCubit.callApiCanCel(context);
                  //           });
                  //         },
                  //         child: const Text(
                  //           'Huỷ đơn hàng',
                  //           style: TextStyle(
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w500,
                  //               color: Colors.white),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
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
