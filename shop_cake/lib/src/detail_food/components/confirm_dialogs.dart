import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/src/cart_page/ui/cart_page.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Thông báo!",
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Thêm vào giỏ hàng thành công",
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child:  Text(
                  "Đóng",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: kMainBlueColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async{
                 await NavigatorManager.push(
                    context,
                    const CartPage(
                      isShowIconBack: true,
                    ),
                  );
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, true);
                },
                child: Text(
                  "Đi đến giỏ hàng",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: kMainRedColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
