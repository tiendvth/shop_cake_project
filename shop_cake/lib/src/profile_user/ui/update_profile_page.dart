import 'package:common/common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/common/config/format_date.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/profile_user/bloc/profile_user_cubit.dart';
import 'package:shop_cake/src/profile_user/repository/repository.dart';
import 'package:shop_cake/utils/utils.dart';
import 'package:shop_cake/widgets/c_textformfield.dart';

class UpdateProfilePage extends StatefulWidget {
  final data;
  final VoidCallback onBack;

  const UpdateProfilePage({Key? key, this.data, required this.onBack})
      : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _profileUserCubit =
      ProfileUserCubit(ProfileUserRepositoryImpl(apiProvider));
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;

  late final TextEditingController _addressController;
  late final TextEditingController _birthdayController;

  @override
  void initState() {
    _profileUserCubit.getProfile();
    _getProfile();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }
  void _getProfile() {
    if(widget.data['fullName'] != null) {
      _nameController = TextEditingController(text: widget.data['fullName']);
    } else {
      _nameController = TextEditingController(text: '');
    }
    if(widget.data['telephone'] != null) {
      _phoneController = TextEditingController(text: widget.data['telephone']);
    } else {
      _phoneController = TextEditingController(text: '');
    }
    if(widget.data['email'] != null) {
      _emailController = TextEditingController(text: widget.data['email']);
    } else {
      _emailController = TextEditingController(text: '');
    }
    if(widget.data['address'] != null) {
      _addressController = TextEditingController(text: widget.data['address']);
    } else {
      _addressController = TextEditingController(text: '');
    }
    if(widget.data['birthday'] != null) {
      _birthdayController = TextEditingController(text: FormatDate.dateFormat(widget.data['birthday']));
    } else {
      _birthdayController = TextEditingController(text: '');
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _profileUserCubit,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kMainWhiteColor,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: kBgMenu,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kMainDarkColor,
            ),
          ),
          elevation: 0,
          title: Text(
            "Chỉnh sửa thông tin cá nhân",
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: kMainDarkColor,
              ),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ProfileUserCubit, ProfileUserState>(
                builder: (context, state) {
                  if (state is ProfileUserSuccess) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Chỉnh sửa thông tin cá nhân",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: kMainBlackColor,
                                ),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Họ và tên",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: kMainBlackColor,
                                ),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CTextFormField(
                              hintText: 'Nhập họ và tên',
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: k9B9B9B,
                              ),
                              controller: _nameController,
                              labelStyle: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: kMainBlackColor.withOpacity(0.7),
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
                              "Số điện thoại",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: kMainBlackColor,
                                ),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CTextFormField(
                              hintText: 'Nhập số điện thoại',
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: k9B9B9B,
                              ),
                              controller: _phoneController,
                              textInputType: TextInputType.number,
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
                              "Địa chỉ email",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: kMainBlackColor,
                                ),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CTextFormField(
                              hintText: 'Nhập email',
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: k9B9B9B,
                              ),
                              controller: _emailController,
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
                              "Địa chỉ",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: kMainBlackColor,
                                ),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CTextFormField(
                              hintText: 'Nhập địa chỉ',
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: k9B9B9B,
                              ),
                              controller: _addressController,
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
                              "Ngày sinh",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: kMainBlackColor,
                                ),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 8,
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
                              controller: _birthdayController,
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
                                    firstDate: DateTime(1010),
                                    lastDate: DateTime(2100),
                                    builder:
                                        (BuildContext context, Widget? child) {
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
                                        DateFormat('dd-MM-yyyy')
                                            .format(pickedDate);
                                    if (kDebugMode) {
                                      print(formattedDate);
                                    }
                                    setState(() {
                                      _birthdayController.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            InkWell(
                              onTap: () async {
                                 showLoading(context);
                                await _profileUserCubit.updateUser(
                                  _addressController.text,
                                  _phoneController.text,
                                  _nameController.text,
                                  _birthdayController.text,
                                );
                                 // ignore: use_build_context_synchronously
                                 await closeLoading(context);
                                 Future.delayed(const Duration(milliseconds: 200), () {
                                   Navigator.pop(context);
                                 });
                                widget.onBack();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kMainRedColor.withOpacity(0.5),
                                ),
                                width: double.infinity,
                                height: 40,
                                child: Center(
                                  child: Text(
                                    "Cập nhật",
                                    style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
