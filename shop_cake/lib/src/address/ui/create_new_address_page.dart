import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/src/address/bloc/get_address_cubit.dart';
import 'package:shop_cake/src/address/model/viet_nam_model.dart';
import 'package:shop_cake/widgets/c_textformfield.dart';

class CreateNewAddressPage extends StatefulWidget {
  const CreateNewAddressPage({Key? key}) : super(key: key);

  @override
  State<CreateNewAddressPage> createState() => _CreateNewAddressPageState();
}

class _CreateNewAddressPageState extends State<CreateNewAddressPage> {
  late final GetAddressCubit getAddressCubit = GetAddressCubit();
  Locations? selectedLocations;
  Districts? selectedDistricts;
  Wards? selectedWards;
  List<Districts> districtList = [];
  List<Wards> wardList = [];

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
                  textInputType: TextInputType.name,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
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
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: kMainBlackColor,
                  ),
                  textInputType: TextInputType.phone,
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
                BlocBuilder<GetAddressCubit, GetAddressState>(
                  builder: (context, state) {
                    if (state is GetAddressLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetAddressSuccess) {
                      List<Locations>? locations = state.locations!;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tỉnh/Thành phố',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          DropdownButtonFormField<Locations>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: k9B9B9B,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: k9B9B9B,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: k9B9B9B,
                                ),
                              ),
                            ),
                            hint: Text('Tỉnh/Thành phố',
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: k9B9B9B)),
                            value: selectedLocations,
                            items: locations.map((location) {
                              return DropdownMenuItem<Locations>(
                                value: location,
                                child: Text(
                                  location.province!,
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: kMainBlackColor,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (selectedLocation) {
                              setState(() {
                                selectedLocations = selectedLocation;
                                selectedDistricts = null;
                                selectedWards = null;
                                districtList =
                                    selectedLocation?.districts ?? [];
                                wardList = [];
                              });
                            },
                            borderRadius: BorderRadius.circular(8),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Quận/Huyện',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          DropdownButtonFormField<Districts>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: k9B9B9B,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: k9B9B9B,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: k9B9B9B,
                                ),
                              ),
                            ),
                            borderRadius: BorderRadius.circular(8),
                            hint: Text('Quận/Huyện',
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: k9B9B9B)),
                            value: selectedDistricts,
                            items:
                                selectedLocations?.districts?.map((district) {
                                      return DropdownMenuItem<Districts>(
                                        value: district,
                                        child: Text(
                                          district.district!,
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: kMainBlackColor,
                                          ),
                                        ),
                                      );
                                    }).toList() ??
                                    [],
                            onChanged: (selectedDistrict) {
                              setState(() {
                                selectedDistricts = selectedDistrict;
                                selectedWards = null;
                                wardList = selectedDistrict?.wards ?? [];
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Phường/Xã',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          DropdownButtonFormField<Wards>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: k9B9B9B,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: k9B9B9B,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: k9B9B9B,
                                ),
                              ),
                            ),
                            borderRadius: BorderRadius.circular(8),
                            hint: Text(
                              'Chọn phường/xã',
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: k9B9B9B),
                            ),
                            value: selectedWards,
                            items: selectedDistricts?.wards?.map((ward) {
                                  return DropdownMenuItem<Wards>(
                                    value: ward,
                                    child: Text(
                                      ward.ward!,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: kMainBlackColor,
                                      ),
                                    ),
                                  );
                                }).toList() ??
                                [],
                            onChanged: (selectedWard) {
                              setState(() {
                                selectedWards = selectedWard;
                              });
                            },
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
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  onComplete: () {
                    //FocusManager.instance.primaryFocus?.dispose();
                  },
                  contentPadding:
                      const EdgeInsets.only(top: 12, bottom: 12, left: 16),
                ),
                const SizedBox(
                  height: 32,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
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
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
