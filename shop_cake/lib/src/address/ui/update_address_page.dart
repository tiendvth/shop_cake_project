import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/src/address/address_request/address_request.dart';
import 'package:shop_cake/src/address/bloc/get_address_cubit.dart';
import 'package:shop_cake/src/address/bloc/get_location_cubit.dart';
import 'package:shop_cake/src/address/model/viet_nam_model.dart';
import 'package:shop_cake/utils/utils.dart';
import 'package:shop_cake/widgets/c_textformfield.dart';

class UpdateAddressPage extends StatefulWidget {
  final String? fullName;
  final String? phone;
  final String? address;
  final String? location;
  final String? district;
  final String? ward;

  const UpdateAddressPage({
    Key? key,
    this.fullName,
    this.phone,
    this.address,
    this.location,
    this.district,
    this.ward,
  }) : super(key: key);

  @override
  State<UpdateAddressPage> createState() => _UpdateAddressPageState();
}

class _UpdateAddressPageState extends State<UpdateAddressPage> {
  late final GetLocationCubit getLocationCubit = GetLocationCubit();
  late final GetAddressCubit getAddressCubit = GetAddressCubit();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;

  // late final TextEditingController _noteController;
  String? provinceValue;
  String? districtValue;
  String? wardValue;

  Locations? selectedLocations;
  Districts? selectedDistricts;
  Wards? selectedWards;
  List<Districts> districtList = [];
  List<Wards> wardList = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.fullName);
    _phoneController = TextEditingController(text: widget.phone);
    _addressController = TextEditingController(text: widget.address);
    provinceValue = widget.location;
    districtValue = widget.district;
    wardValue = widget.ward;
    // _noteController = TextEditingController(text: widget.data);
    // selectedLocations = Locations(province: widget.location);
    // selectedDistricts = Districts(district: widget.district);
    // selectedWards = Wards(ward: widget.ward);
    getLocationCubit.loadLocationData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    // _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getLocationCubit,
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
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
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
                    controller: _nameController,
                    focusNode: FocusNode(),
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
                    controller: _phoneController,
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
                  BlocBuilder<GetLocationCubit, GetLocationState>(
                    builder: (context, state) {
                      if (state is GetAddressLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GetLocationSuccess) {
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
                              hint: provinceValue != null
                                  ? Text(provinceValue!,
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: k9B9B9B))
                                  : Text('Tỉnh/Thành phố',
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
                              hint: districtValue != null
                                  ? Text(districtValue!,
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: k9B9B9B))
                                  : Text('Quận/Huyện',
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
                              hint: wardValue != null
                                  ? Text(
                                      wardValue!,
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: k9B9B9B),
                                    )
                                  : Text(
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
                    controller: _addressController,
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
                    onTap: () {
                      if (selectedLocations != null &&
                          selectedDistricts != null &&
                          selectedWards != null &&
                          _addressController.text.isNotEmpty) {
                        var address =
                            '${_addressController.text},${selectedWards!.ward!}, ${selectedDistricts!.district!},${selectedLocations!.province!}';
                        final data = AddressRequest(
                          address: address,
                          phone: _phoneController.text,
                        );
                        getAddressCubit.createAddress(
                          phone: _phoneController.text,
                          name: _nameController.text,
                          address: address,
                        );
                        Navigator.pop(context, data);
                      } else {
                        showToast('Vui lòng nhập đầy đủ thông tin');
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: kButtonGradient,
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
      ),
    );
  }
}