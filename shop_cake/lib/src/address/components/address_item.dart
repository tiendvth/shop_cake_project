import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/widgets/space_extention.dart';

class AddressItem extends StatelessWidget {
  final String? name;
  final String? address;
  final String? phone;
  final GestureTapCallback? onTapEdit;
  final GestureTapCallback? onTapDelete;
  final int? isSelected;
  final GestureTapCallback? onTapSelected;

  const AddressItem({
    Key? key,
    this.name,
    this.address,
    this.phone,
    this.onTapEdit,
    this.onTapDelete,
    this.isSelected,
    this.onTapSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTapSelected,
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: k666666,
                width: 1,
              ),
              color: isSelected == 1 ? Colors.white : Colors.transparent,
            ),
            child: isSelected == 1
                ? Center(
              child: Container(
                width: 12,
                height: 12,
                decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  color: kMainDarkColor.withOpacity(0.5),
                ),
              ),
            )
                : null,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name ?? 'Nguyễn Văn A',
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
        const SizedBox(
          width: 8,
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
