import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/src/address/bloc/get_address_cubit.dart';
import 'package:shop_cake/widgets/c_textformfield.dart';

class CreateNewAddressPage extends StatefulWidget {
  const CreateNewAddressPage({Key? key}) : super(key: key);

  @override
  State<CreateNewAddressPage> createState() => _CreateNewAddressPageState();
}

class _CreateNewAddressPageState extends State<CreateNewAddressPage> {
  late final GetAddressCubit getAddressCubit = GetAddressCubit();

  @override
  void initState() {
    super.initState();
    getAddressCubit.loadLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getAddressCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Thêm địa chỉ mới',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: kMainRedColor,
              )),
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: kBgMenu,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Tạo địa chỉ mới',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Tên đây đủ',
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
                  onComplete: () {
                    //FocusManager.instance.primaryFocus?.dispose();
                  },
                  contentPadding:
                      const EdgeInsets.only(top: 12, bottom: 12, left: 16),
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
                  onComplete: () {
                    //FocusManager.instance.primaryFocus?.dispose();
                  },
                  contentPadding:
                      const EdgeInsets.only(top: 12, bottom: 12, left: 16),
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
                  builder: (context, state) {
                    if (state is GetAddressLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetAddressSuccess) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              hintText: 'Chọn tỉnh/thành phố',
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: k9B9B9B,
                              ),
                              contentPadding: const EdgeInsets.only(
                                  top: 12, bottom: 12, left: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: k9B9B9B,
                                ),
                              ),
                            ),
                            items: state.vietNamModel
                                ?.map((e) => DropdownMenuItem(
                                      value: e.name,
                                      child: Text(
                                        e.name ?? '',
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: k9B9B9B,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              print(value);
                            },
                            value: state.vietNamModel?.first.name ?? '',
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Quận/huyện',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              hintText: 'Chọn quận/huyện',
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: k9B9B9B,
                              ),
                              contentPadding: const EdgeInsets.only(
                                  top: 12, bottom: 12, left: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: k9B9B9B,
                                ),
                              ),
                            ),
                            items: state.vietNamModel
                                ?.first.districts
                                ?.map((e) => DropdownMenuItem(
                                      value: e.name,
                                      child: Text(
                                        e.name ?? '',
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: k9B9B9B,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              print(value);
                            },
                            value: state.vietNamModel?.first.districts?.first.name ?? '',
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Phường/xã',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              hintText: 'Chọn phường/xã',
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: k9B9B9B,
                              ),
                              contentPadding: const EdgeInsets.only(
                                  top: 12, bottom: 12, left: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: k9B9B9B,
                                ),
                              ),
                            ),
                            items: state.vietNamModel
                                ?.first
                                .districts
                                ?.first
                                .wards
                                ?.map((e) => DropdownMenuItem(
                                      value: e.name,
                                      child: Text(
                                        e.name ?? '',
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: k9B9B9B,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              print(value);
                            },
                            value: state.vietNamModel?.first.districts?.first.wards?.first.name ?? '',
                          ),
                        ],
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
                  'Địa chỉ chi tiết',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                CTextFormField(
                  hintText: 'Địa chỉ chi tiết',
                  hintStyle: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: k9B9B9B,
                  ),
                  onComplete: () {
                    //FocusManager.instance.primaryFocus?.dispose();
                  },
                  contentPadding: const EdgeInsets.only(
                      top: 12, bottom: 12, left: 16),
                ),
                const SizedBox(
                  height: 32,
                ),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: kMainGradient,
                  ),
                  child: Center(
                    child: Text(
                      'Lưu',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
