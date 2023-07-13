import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/src/address/bloc/get_address_cubit.dart';
import 'package:shop_cake/src/address/components/address_item.dart';
import 'package:shop_cake/src/address/ui/create_new_address_page.dart';
import 'package:shop_cake/widgets/space_extention.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final GetAddressCubit addressCubit = GetAddressCubit();


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
          title: Text('Địa chỉ của tôi',
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
            child: BlocBuilder<GetAddressCubit, GetAddressState>(
              builder: (context, state) {
                if (state is GetAddressLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else
                if (state is GetAddressSuccess) {
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
                          print(state.address?[index].address);
                          return Column(
                            children: [
                              12.spaceHeight,
                               AddressItem(
                                name: 'Đặng Văn Tiến',
                                address: state.address?[index].address,
                                 phone: state.address?[index].phone,
                              ),
                              12.spaceHeight,
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24),
                                child: Divider(
                                    thickness: 0.5,
                                    color: kMainDarkGreyColor
                                ),
                              )
                            ],
                          );
                        },
                      ),
                      32.spaceHeight,
                      InkWell(
                        onTap: () {
                          NavigatorManager.push(
                            context,
                            const CreateNewAddressPage(),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: kMainRedColor),
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
