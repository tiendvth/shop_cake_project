import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/constants.dart';

class DialogFilter extends StatelessWidget {
  final String? priceFrom;
  final String? priceTo;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onTapClear;
  final Widget? child;

  const DialogFilter({
    Key? key,
    this.priceFrom,
    this.priceTo,
    this.onTap,
    this.child,
    this.onTapClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(32),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Container(
        height: 380,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            )),
        child: Column(
          children: [
            Text(
              'Lọc sản phẩm',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Divider(
              thickness: 0.2,
              color: Colors.black,
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: child!,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onTapClear,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Hủy',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: onTap,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: kMainRedColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Lọc',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
