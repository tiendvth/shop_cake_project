import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/widgets/space_extention.dart';

class AddressItem extends StatelessWidget {
  final String? name;
  final String? address;
  final String? phone;

  const AddressItem({
    Key? key,
    this.name,
    this.address,
    this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: 1,
          groupValue: 1,
          onChanged: (value) {},
          activeColor: kMainRedColor.withOpacity(0.5),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nguyễn Văn A',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              4.spaceHeight,
              Text(
                'Số 1, Ngõ 1, Phố 1, Quận 1, TP. Hồ Chí Minh',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: k666666,
                ),
              ),
              4.spaceHeight,
              Text(
                '0123456789',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: k666666,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.edit),
        ),
      ],
    );
  }
}
