import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/widgets/c_image.dart';

class CLabel extends StatelessWidget {
  final String? image;
  final String? title;
  final String? subText;
  final bool? icNext;
  final GestureTapCallback? onTab;
  final double? width;
  final bool? color;
  final bool? colorText;

  const CLabel({
    Key? key,
    this.image,
    this.title,
    this.onTab,
    this.subText,
    this.icNext = true,
    this.width,
    this.color,
    this.colorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            image != null
                ? Image(
                    image: AssetImage(image ?? ""),
                    color: color == true ? kF2F4B4E : kMainBlackColor,
                    width: 24,
                    height: 24,
                  )
                : const SizedBox(
                    width: 24,
                  ),
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title ?? '',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: colorText == true ? kMainBlackColor : k514D56),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            icNext == true
                ? Row(
                    children: [
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CImage(
                          assetsPath: Assets.icArrowRight,
                        ),
                      ),
                      SizedBox(
                        width: width ?? 0,
                      )
                    ],
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
