import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/src/address/bloc/get_address_cubit.dart';
import 'package:shop_cake/src/address/components/address_item.dart';
import 'package:shop_cake/src/address/ui/create_new_address_page.dart';
import 'package:shop_cake/src/address/ui/update_address_page.dart';
import 'package:shop_cake/widgets/space_extention.dart';

class AddressPage extends StatefulWidget {
  final VoidCallback? callback;
  const AddressPage({Key? key, this.callback}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final GetAddressCubit addressCubit = GetAddressCubit();
  int idAddress = 0;
  String? province;
  String? district = '';
  String? ward = '';
  String? detailAddress = '';
  int selectedValue = 0;

  @override
  void initState() {
    super.initState();
    addressCubit.getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => addressCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Địa chỉ của tôi',
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: kMainRedColor,
            ),
          ),
          leading: IconButton(
            onPressed: () async {
              Future.delayed(const Duration(milliseconds: 200), () {
                Navigator.pop(context);
              });
              widget.callback?.call();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kMainWhiteColor,
            ),
          ),
          actions: [
            selectedValue != 0
                ? TextButton(
                    onPressed: () async{
                     await addressCubit.changeDefaultAddress(id: idAddress);
                     addressCubit.getAddress();
                    },
                    child: Text(
                      'Lưu',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: kMainRedColor,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
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
            child: BlocBuilder<GetAddressCubit, GetAddressState>(
              builder: (context, state) {
                if (state is GetAddressLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetAddressSuccess) {
                  if (state.address != null && state.address!.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Tất cả địa chỉ',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.address?.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  12.spaceHeight,
                                  AddressItem(
                                    name: state.address?[index].name,
                                    address:
                                        state.address?[index].address,
                                    phone: state.address?[index].phone,
                                    isSelected: state.address?[index].status == 1
                                        ? 1
                                        : 0,
                                    onTapSelected: () {
                                      setState(() {
                                        for (int i = 0; i < state.address!.length; i++) {
                                          if (state.address![i].id == state.address![index].id) {
                                            state.address![i].status = 1; // Đánh dấu đối tượng được chọn (1)
                                            idAddress = state.address![i].id!;
                                            selectedValue = state.address![index].status!;
                                          } else {
                                            state.address![i].status = 0;// Đánh dấu các đối tượng khác không được chọn (0)
                                            selectedValue = state.address![index].status!;
                                          }
                                        }
                                      });
                                    },
                                    onTapEdit: () {
                                      NavigatorManager.push(
                                        context,
                                        UpdateAddressPage(
                                          address: state
                                              .address?[index].address,
                                          phone:
                                              state.address?[index].phone,
                                          fullName: state
                                              .address?[index].name,
                                          id: state.address?[index].id,
                                        ),
                                      );
                                    },
                                    onTapDelete: () async {
                                      await addressCubit.deleteAddress(
                                          id: state.address?[index].id);
                                      addressCubit.getAddress();
                                    },
                                  ),
                                ],
                              );
                            // } else {
                            //   return const SizedBox(); // Trả về widget trống nếu danh sách rỗng hoặc vị trí index không hợp lệ
                            // }
                          },
                        ),
                        32.spaceHeight,
                        InkWell(
                          onTap: () {
                            NavigatorManager.push(
                              context,
                              CreateNewAddressPage(
                                callback: () {
                                  addressCubit.getAddress();
                                },
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.5, color: kMainRedColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  16.spaceWidth,
                                  const Icon(
                                    Icons.add,
                                    color: kMainRedColor,
                                  ),
                                  Text(
                                    'Thêm địa chỉ mới',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: kMainRedColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        Center(
                          child: Text(
                            'Chưa có địa chỉ nào',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: kMainGreyColor,
                            ),
                          ),
                        ),
                        32.spaceHeight,
                        InkWell(
                          onTap: () {
                            NavigatorManager.push(
                              context,
                              CreateNewAddressPage(
                                callback: () {
                                  addressCubit.getAddress();
                                },
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.5, color: kMainRedColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  16.spaceWidth,
                                  const Icon(
                                    Icons.add,
                                    color: kMainRedColor,
                                  ),
                                  Text(
                                    'Thêm địa chỉ mới',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: kMainRedColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                } else {
                  return const Center(
                    child: Text('Lỗi'),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
