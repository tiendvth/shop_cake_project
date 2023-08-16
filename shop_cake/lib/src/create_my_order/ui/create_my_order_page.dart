import 'dart:io';

import 'package:common/common.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/constants/font_size/font_size.dart';
import 'package:shop_cake/src/address/bloc/get_address_cubit.dart';
import 'package:shop_cake/src/address/ui/address_page.dart';
import 'package:shop_cake/widgets/c_textformfield.dart';

class CreateMyOrderPage extends StatefulWidget {
  const CreateMyOrderPage({Key? key}) : super(key: key);

  @override
  State<CreateMyOrderPage> createState() => _CreateMyOrderPageState();
}

class _CreateMyOrderPageState extends State<CreateMyOrderPage> {
  late final TextEditingController usernameController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;
  late final TextEditingController noteController;
  late final TextEditingController dateController;
  final GetAddressCubit getAddressCubit = GetAddressCubit();
  late final FocusNode dateFocusNode;
  late final FocusNode usernameFocusNode;
  late final FocusNode phoneFocusNode;
  late final FocusNode addressFocusNode;
  late final FocusNode noteFocusNode;
  XFile? image;

  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    noteController = TextEditingController();
    usernameFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    addressFocusNode = FocusNode();
    noteFocusNode = FocusNode();
    dateController = TextEditingController();
    dateFocusNode = FocusNode();
    getAddressCubit.getAddress();
  }

  @override
  void dispose() {
    usernameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    noteController.dispose();
    usernameFocusNode.dispose();
    phoneFocusNode.dispose();
    addressFocusNode.dispose();
    noteFocusNode.dispose();
    dateController.dispose();
    dateFocusNode.dispose();
    super.dispose();
  }

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img;
      print('image: ${image?.path}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getAddressCubit,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kMainWhiteColor,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              gradient: kBgMenu,
            ),
          ),
          title: Text(
            'Tạo đơn hàng',
            style: GoogleFonts.roboto(
              fontSize: FontSize.fontSize_18,
              fontWeight: FontWeight.w500,
              color: kMainDarkColor,
            ),
          ),
          actions: [
            // icon thông báo
            IconButton(
              onPressed: () {
                // NavigatorManager.push(
                //   context,
                //   const NotificationPage(),
                // );
              },
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: kMainDarkColor,
              ),
            ),
          ],
          centerTitle: true,
        ),
        backgroundColor: const Color(0xfFFFFFFF),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tạo đơn hàng dành riêng cho bạn',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Thông tin người nhận',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                CTextFormField(
                  hintText: 'Họ và tên',
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
                  onComplete: () {
                    //FocusManager.instance.primaryFocus?.dispose();
                  },
                  contentPadding: const EdgeInsets.only(
                      top: 12, bottom: 12, left: 16),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Số điện thoại',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                CTextFormField(
                  hintText: 'Số điện thoại',
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
                  onComplete: () {
                    //FocusManager.instance.primaryFocus?.dispose();
                  },
                  contentPadding: const EdgeInsets.only(
                      top: 12, bottom: 12, left: 16),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Địa chỉ',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                BlocBuilder<GetAddressCubit, GetAddressState>(
                  builder: (context, stateAddress) {
                    if (stateAddress is GetAddressLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (stateAddress is GetAddressSuccess) {
                      return InkWell(
                        onTap: () {
                          NavigatorManager.push(
                            context,
                            AddressPage(
                              callback: () =>
                                  getAddressCubit.getAddress(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, left: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: kMainDarkGreyColor,
                              width: 0.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child:stateAddress.address !=
                                    null && stateAddress
                                    .address!.isNotEmpty ? Text(
                                  stateAddress.address
                                      ?.firstWhere((element) =>
                                  element.status == 1)
                                      .address ??
                                      '',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: k9B9B9B,
                                  ),
                                ) : Center(
                                  child: Text(
                                    'Chọn địa chỉ',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: k9B9B9B,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              const Center(
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: kF2F4B4E,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('Lỗi'),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Ghi chú',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                CTextFormField(
                  hintText: 'Ghi chú',
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
                  maxLines: 4,
                  onComplete: () {
                    //FocusManager.instance.primaryFocus?.dispose();
                  },
                  contentPadding: const EdgeInsets.only(
                      top: 12, bottom: 12, left: 16),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Ngày giao hàng',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CTextFormField(
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
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                        builder: (BuildContext context, Widget? child) {
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
                        DateFormat('MM-dd-yyyy').format(pickedDate);
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
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Thêm ảnh mẫu sản phẩm',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: DottedBorder(
                        color: k9B9B9B,
                        strokeWidth: 1,
                        borderType: BorderType.RRect,
                        strokeCap: StrokeCap.butt,
                        radius: const Radius.circular(8),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              // FocusManager.instance.primaryFocus?.dispose();
                              final ImagePicker _picker = ImagePicker();
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: 120,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          onTap: () async {
                                            getImage(
                                              ImageSource.camera,
                                            );
                                            Navigator.pop(context);
                                          },
                                          leading: const Icon(
                                            Icons.camera_alt,
                                            color: kF2F4B4E,
                                          ),
                                          title: Text(
                                            'Chụp ảnh',
                                            style: GoogleFonts.roboto(
                                              color: kMainRedColor
                                                  .withOpacity(0.7),
                                              fontWeight:
                                              FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          onTap: () async {
                                            getImage(
                                              ImageSource.gallery,
                                            );
                                            Navigator.pop(context);
                                          },
                                          leading: const Icon(
                                            Icons.photo,
                                            color: kF2F4B4E,
                                          ),
                                          title: Text(
                                            'Chọn ảnh',
                                            style: GoogleFonts.roboto(
                                              color: kMainRedColor
                                                  .withOpacity(0.7),
                                              fontWeight:
                                              FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.add,
                              color: k9B9B9B,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    image != null
                        ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child:
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(image!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kMainRedColor.withOpacity(0.5),
                    minimumSize: const Size(double.infinity, 44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Tạo đơn hàng'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
