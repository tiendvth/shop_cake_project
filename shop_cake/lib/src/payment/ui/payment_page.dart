import 'package:common/common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/common/%20config/format_text_to_number.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/constants/font_size/font_size.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/address/bloc/get_address_cubit.dart';
import 'package:shop_cake/src/cart_page/componenst/cart_item.dart';
import 'package:shop_cake/src/cart_page/repository/cart_repository.dart';
import 'package:shop_cake/src/payment/bloc/payment_cubit.dart';
import 'package:shop_cake/src/payment/repository/repository.dart';
import 'package:shop_cake/widgets/c_button.dart';
import 'package:shop_cake/widgets/c_textformfield.dart';
import 'package:shop_cake/widgets/space_extention.dart';

class PaymentPage extends StatefulWidget {
  final VoidCallback? callback;

  const PaymentPage({Key? key, required this.callback}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final GetAddressCubit getAddressCubit = GetAddressCubit();
  final paymentCubit = PaymentCubit(
      PaymentRepositoryImpl(apiProvider), CartRepositoryImpl(apiProvider));
  final TextEditingController dateController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    paymentCubit.getPayment();
    getAddressCubit.getAddress();
  }

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
    noteController.dispose();
    reasonController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: false,
        bottom: true,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => paymentCubit,
            ),
            BlocProvider(
              create: (context) => getAddressCubit,
            ),
          ],
          child: BlocBuilder<GetAddressCubit, GetAddressState>(
            builder: (context, stateAddress) {
              if (stateAddress is GetAddressSuccess) {
                return BlocBuilder<PaymentCubit, PaymentState>(
                  builder: (context, state) {
                    if (state is PaymentSuccess) {
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                              padding: EdgeInsets.fromLTRB(24,
                                  AppBar().preferredSize.height + 65, 24, 0),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    itemBuilder: (context, index) {
                                      // print(state.data[index]['quantity']);
                                      return Column(
                                        children: [
                                          CartItem(
                                            name: state.datas[index]['name'],
                                            price: state.datas[index]['price'],
                                            quantity: state.datas[index]
                                                ['quantityShoppingCartTmt'],
                                            imageUrl: state.datas[index]
                                                ['image'],
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                        ],
                                      );
                                    },
                                    itemCount: state.datas.length,
                                    shrinkWrap: true,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      'Ngày giao hàng',
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: CTextFormField(
                                      hintText: 'Ngày',
                                      hintStyle: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: k9B9B9B,
                                      ),
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: kMainBlackColor,
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                        top: 12,
                                        bottom: 12,
                                        left: 16,
                                      ),
                                      textInputType: TextInputType.datetime,
                                      controller: dateController,
                                      onComplete: () {
                                        //FocusManager.instance.primaryFocus?.dispose();
                                      },
                                      onchanged: (value) {
                                        print(value);
                                      },
                                      suffixIcon: IconButton(
                                        icon: const Icon(
                                          Icons.calendar_month_outlined,
                                          color: k9B9B9B,
                                        ),
                                        onPressed: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2100),
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return Theme(
                                                data:
                                                    ThemeData.light().copyWith(
                                                  colorScheme:
                                                      const ColorScheme.light(
                                                    primary: kMainDarkColor,
                                                    onPrimary: Colors.white,
                                                    surface: kMainDarkColor,
                                                    onSurface: kMainDarkColor,
                                                  ),
                                                  dialogBackgroundColor:
                                                      Colors.white,
                                                ),
                                                child: child!,
                                              );
                                            },
                                          );
                                          if (pickedDate != null) {
                                            if (kDebugMode) {
                                              print(pickedDate);
                                            }
                                            String formattedDate =
                                                DateFormat('yyyy-MM-dd HH:mm')
                                                    .format(pickedDate);
                                            if (kDebugMode) {
                                              print(formattedDate);
                                            }
                                            setState(() {
                                              dateController.text =
                                                  formattedDate; //set output date to TextField value.
                                            });
                                          } else {
                                            print("Date is not selected");
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  16.spaceHeight,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      'Ghi chú',
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: kMainBlackColor,
                                      ),
                                    ),
                                  ),
                                  8.spaceHeight,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: CTextFormField(
                                      hintText: 'Ghi chú',
                                      hintStyle: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: k9B9B9B,
                                      ),
                                      controller: noteController,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: kMainBlackColor,
                                      ),
                                      maxLines: 4,
                                      onComplete: () {
                                        //FocusManager.instance.primaryFocus?.dispose();
                                      },
                                      contentPadding: const EdgeInsets.only(
                                          top: 12, bottom: 12, left: 16),
                                    ),
                                  ),
                                  20.spaceHeight,
                                  // Container(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 16, vertical: 4),
                                  //   margin: const EdgeInsets.symmetric(
                                  //       horizontal: 16, vertical: 7),
                                  //   decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(8),
                                  //       border: Border.all(width: 0.5)),
                                  //   child: DropdownButtonHideUnderline(
                                  //     child: DropdownButton2(
                                  //       hint: Text(
                                  //         'Select Item',
                                  //         style: TextStyle(
                                  //           fontSize: 14,
                                  //           color: Theme.of(context).hintColor,
                                  //         ),
                                  //       ),
                                  //       items: paymentCubit.items
                                  //           .map((item) => DropdownMenuItem<String>(
                                  //         value: item,
                                  //         child: Text(
                                  //           item,
                                  //           style: const TextStyle(
                                  //             fontSize: 14,
                                  //           ),
                                  //         ),
                                  //       ))
                                  //           .toList(),
                                  //       value: paymentCubit.selectedValue,
                                  //       onChanged: (value) {
                                  //         paymentCubit.selectedValue =
                                  //         value as String;
                                  //         paymentCubit.updateTypeShip();
                                  //       },
                                  //       buttonHeight: 40,
                                  //       buttonWidth: double.infinity,
                                  //       itemHeight: 40,
                                  //     ),
                                  //   ),
                                  // ),
                                  // Padding(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 16, vertical: 4),
                                  //     child: TextFormField(
                                  //       controller: paymentCubit.noteController,
                                  //       decoration: InputDecoration(
                                  //           border: OutlineInputBorder(
                                  //             borderRadius: BorderRadius.circular(8),
                                  //           ),
                                  //           hintStyle: GoogleFonts.roboto(
                                  //             fontSize: 14,
                                  //             fontWeight: FontWeight.w400,
                                  //             color: k9B9B9B,
                                  //           ),
                                  //           contentPadding:
                                  //           const EdgeInsets.symmetric(
                                  //               horizontal: 16, vertical: 4),
                                  //           hintText: 'Nhập ghi chú'),
                                  //     )),
                                  // Visibility(
                                  //   visible: paymentCubit.selectedValue ==
                                  //       paymentCubit.items[1],
                                  //   child: Column(
                                  //     mainAxisSize: MainAxisSize.min,
                                  //     children: [
                                  //       Padding(
                                  //           padding: const EdgeInsets.symmetric(
                                  //               horizontal: 16, vertical: 4),
                                  //           child: TextFormField(
                                  //             controller: paymentCubit.nameController,
                                  //             decoration: InputDecoration(
                                  //                 border: OutlineInputBorder(
                                  //                   borderRadius:
                                  //                   BorderRadius.circular(8),
                                  //                 ),
                                  //                 hintText: 'Nhập tên của bạn'),
                                  //           )),
                                  //       Padding(
                                  //         padding: const EdgeInsets.symmetric(
                                  //             horizontal: 16, vertical: 4),
                                  //         child: TextFormField(
                                  //           controller: paymentCubit.phoneController,
                                  //           keyboardType: TextInputType.number,
                                  //           decoration: InputDecoration(
                                  //             border: OutlineInputBorder(
                                  //               borderRadius:
                                  //               BorderRadius.circular(8),
                                  //             ),
                                  //             hintText: 'Nhập số điện thoại',
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       Padding(
                                  //           padding: const EdgeInsets.fromLTRB(
                                  //               24, 10, 24, 10),
                                  //           child: TextFormField(
                                  //             controller:
                                  //             paymentCubit.addressController,
                                  //             decoration: InputDecoration(
                                  //                 border: OutlineInputBorder(
                                  //                   borderRadius:
                                  //                   BorderRadius.circular(12),
                                  //                 ),
                                  //                 focusedBorder: OutlineInputBorder(
                                  //                   borderRadius:
                                  //                   BorderRadius.circular(12),
                                  //                   borderSide: const BorderSide(
                                  //                       color: kMainRedColor),
                                  //                 ),
                                  //                 hintText: 'Nhập địa chỉ'),
                                  //           )),
                                  //     ],
                                  //   ),
                                  // ),
                                  // const SizedBox(
                                  //   height: 16,
                                  // ),
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
                                  onPressed: () async {
                                    // await Navigator.push(
                                    //      context,
                                    //      MaterialPageRoute(
                                    //          builder: (context) =>
                                    //               VnPayPaymentPage()));
                                    await paymentCubit.callApiPayment(
                                        context,
                                        dateController.text,
                                        state.datas,
                                        noteController.text,
                                        reasonController.text,
                                        stateAddress.address![0].id!);
                                    Future.delayed(
                                        const Duration(milliseconds: 500), () {
                                      Navigator.pop(context);
                                      widget.callback!();
                                    });
                                    // Navigator.pop(context);
                                    // widget.callback!();
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
