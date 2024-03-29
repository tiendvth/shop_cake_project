import 'package:common/common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/common/config/format_price.dart';
import 'package:shop_cake/common/config/format_text_to_number.dart';
import 'package:shop_cake/common/config_read_file.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/constants/font_size/font_size.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/address/bloc/get_address_cubit.dart';
import 'package:shop_cake/src/address/ui/address_page.dart';
import 'package:shop_cake/src/cart_page/componenst/cart_item.dart';
import 'package:shop_cake/src/cart_page/repository/cart_repository.dart';
import 'package:shop_cake/src/payment/bloc/payment_cubit.dart';
import 'package:shop_cake/src/payment/repository/repository.dart';
import 'package:shop_cake/src/payment/ui/payment_methods_page.dart';
import 'package:shop_cake/utils/utils.dart';
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
  final TextEditingController timeController = TextEditingController();
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
    timeController.dispose();
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
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
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
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: kMainDarkColor,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          widget.callback!();
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
                                  AppBar().preferredSize.height + 55, 24, 0),
                              child: Container(
                                height: 120,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FontColor.colorFFFFFF,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          kMainDarkGreyColor.withOpacity(0.2),
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
                                            name: state.datas[index]['nameCake'],
                                            price: FormatPrice.formatVND(
                                                state.datas[index]
                                                ['priceCake']),
                                            quantity: state.datas[index]
                                                ['quantityShoppingCartTmt'],
                                            imageUrl: ReadFile.readFile(
                                                state.datas[index]
                                                ['imageCake']),
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                                    child: Row(
                                      children: [
                                        Expanded(
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
                                            contentPadding:
                                                const EdgeInsets.only(
                                              top: 12,
                                              bottom: 12,
                                              left: 16,
                                            ),
                                            textInputType:
                                                TextInputType.datetime,
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
                                                  builder:
                                                      (BuildContext context,
                                                          Widget? child) {
                                                    return Theme(
                                                      data: ThemeData.light().copyWith(
                                                        colorScheme: const ColorScheme.light(
                                                          // change the border color
                                                          primary: kFFA6BD,
                                                          // change the text color
                                                          onSurface: kMainDarkColor,
                                                        ),
                                                        // button colors
                                                        buttonTheme: const ButtonThemeData(
                                                          colorScheme: ColorScheme.light(
                                                            primary: Colors.green,
                                                          ),
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
                                                      DateFormat('yyyy-MM-dd')
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
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: CTextFormField(
                                            hintText: 'Giờ',
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
                                            contentPadding:
                                                const EdgeInsets.only(
                                              top: 12,
                                              bottom: 12,
                                              left: 16,
                                            ),
                                            textInputType:
                                                TextInputType.datetime,
                                            controller: timeController,
                                            suffixIcon: IconButton(
                                              icon: const Icon(
                                                Icons.calendar_month_outlined,
                                                color: k9B9B9B,
                                              ),
                                              onPressed: () {
                                                showTimePicker(
                                                  cancelText: 'Đóng',
                                                  confirmText: 'Xác nhận',
                                                  hourLabelText: 'Giờ',
                                                  minuteLabelText: 'Phút',
                                                  helpText: 'Chọn giờ',
                                                  context: context,
                                                  initialEntryMode:
                                                      TimePickerEntryMode.dial,
                                                  initialTime: TimeOfDay.now(),
                                                  builder:
                                                      (BuildContext context,
                                                          Widget? child) {
                                                    return Theme(
                                                      data: ThemeData.light().copyWith(
                                                        colorScheme: const ColorScheme.light(
                                                          // change the border color
                                                          primary: Colors.red,
                                                          // change the text color
                                                          onSurface: Colors.purple,
                                                        ),
                                                        // button colors
                                                      ),
                                                      child: MediaQuery(
                                                        data: MediaQuery.of(
                                                                context)
                                                            .copyWith(
                                                                alwaysUse24HourFormat:
                                                                    false),
                                                        child: child!,
                                                      ),
                                                    );
                                                  },
                                                ).then((value) => {
                                                      if (value != null)
                                                        {
                                                          timeController.text =
                                                              value.format(
                                                                  context)
                                                        }
                                                    });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  16.spaceHeight,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      'Ghi chú',
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                                  // chọn địa chỉ
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      'Địa chỉ nhận hàng',
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: kMainBlackColor,
                                      ),
                                    ),
                                  ),
                                  8.spaceHeight,
                                  InkWell(
                                    onTap: () async {
                                      NavigatorManager.pushFullScreen(context,
                                          AddressPage(
                                        callback: () {
                                          getAddressCubit.getAddress();
                                        },
                                      ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.only(
                                            top: 12, bottom: 12, right: 8),
                                        decoration: const BoxDecoration(
                                            border: Border.symmetric(
                                                horizontal: BorderSide(
                                                    color: kMainGreyColor,
                                                    width: 1))),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: stateAddress.address !=
                                                      null && stateAddress
                                                              .address!.isNotEmpty
                                                  ? Text(
                                                      // lấy ra địa chỉ có status = 1
                                                      stateAddress.address!
                                                              .where((element) =>
                                                                  element
                                                                      .status ==
                                                                  1)
                                                              .first
                                                              .address ??
                                                          '',
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: k9B9B9B,
                                                      ),
                                                    )
                                                  : Text(
                                                      'Chọn địa chỉ',
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: k9B9B9B,
                                                      ),
                                                    ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const Icon(
                                              size: 16,
                                              Icons.arrow_forward_ios,
                                              color: k9B9B9B,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  20.spaceHeight,
                                  // chọn phương thức thanh toán
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      'Phương thức thanh toán',
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: kMainBlackColor,
                                      ),
                                    ),
                                  ),
                                  8.spaceHeight,
                                  InkWell(
                                    onTap: () async {
                                      NavigatorManager.pushFullScreen(
                                          context, const PaymentMethodPage());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.only(
                                            top: 12, bottom: 12, right: 8),
                                        decoration: const BoxDecoration(
                                            border: Border.symmetric(
                                          horizontal: BorderSide(
                                              color: kMainGreyColor, width: 1),
                                        )),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Icon(
                                              Icons.payment,
                                              color: kMainDarkGreyColor,
                                              size: 16,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'Chọn Phương thức thanh toán',
                                              style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: kMainBlackColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Thanh toán khi nhận hàng',
                                                style: GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: kMainDarkGreyColor,
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              color: k9B9B9B,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
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
                                  const SizedBox(
                                    height: 32,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 16,
                              bottom: 16,
                            ),
                            decoration:  BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                top: BorderSide(
                                  color: k9B9B9B.withOpacity(0.2),
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                CButton(
                                  width: double.infinity,
                                  height: 44,
                                  radius: 12,
                                  bgColor: kMainRedColor.withOpacity(0.6),
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
                                    if (dateController.text.isEmpty) {
                                      showToast('Vui lòng chọn ngày');
                                    } else if (timeController.text.isEmpty) {
                                      showToast('Vui lòng chọn giờ');
                                    } else if (stateAddress.address!
                                        .where((element) => element.status == 1).isEmpty || stateAddress.address!.isEmpty || stateAddress.address == null) {
                                      showToast('Vui lòng chọn địa chỉ');
                                    }
                                    else {
                                      final date =
                                          '${dateController.text} ${timeController.text}';
                                      await paymentCubit.callApiPayment(
                                        context,
                                        date,
                                        state.datas,
                                        noteController.text,
                                        reasonController.text,
                                        stateAddress.address!
                                            .firstWhere((element) =>
                                                element.status == 1)
                                            .id!,
                                      );
                                      Future.delayed(
                                          const Duration(milliseconds: 300),
                                          () {
                                        Navigator.pop(context);
                                        widget.callback!();
                                      });
                                    }
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
