import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/widgets/space_extention.dart';

class AddressItem extends StatelessWidget {
  final String? name;
  final String? address;
  final String? phone;
  final int? value;
  final int? groupValue;
  final Function(int?)? onChanged;
  final GestureTapCallback? onTapEdit;
  final GestureTapCallback? onTapDelete;

  const AddressItem({
    Key? key,
    this.name,
    this.address,
    this.phone,
    this.value,
    this.groupValue,
    this.onChanged,
    this.onTapEdit,
    this.onTapDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: value ?? 0,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: kMainRedColor.withOpacity(0.5),
        ),
        // child ?? const SizedBox(),
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
                address ?? 'Số 1, Ngõ 1, Phố 1, Quận 1, TP. Hồ Chí Minh',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: k666666,
                ),
              ),
              4.spaceHeight,
              Text(
                phone ?? '0123456789',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: k666666,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: onTapEdit,
          child: Image.asset(
            Assets.icEdits,
            width: 24,
            height: 24,
          ),
        ),
        12.spaceWidth,
        InkWell(
          onTap: onTapDelete,
          child: Image.asset(
            Assets.icTrash,
            width: 24,
            height: 24,
          ),
        ),
      ],
    );
  }
}
