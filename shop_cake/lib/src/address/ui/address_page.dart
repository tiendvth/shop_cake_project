import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/src/address/components/address_item.dart';
import 'package:shop_cake/src/address/ui/create_new_address_page.dart';
import 'package:shop_cake/widgets/space_extention.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
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
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      12.spaceHeight,
                      const AddressItem(),
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
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
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
          ),
        ),
      ),
    );
  }
}
