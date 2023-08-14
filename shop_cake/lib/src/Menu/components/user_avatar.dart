import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/constants.dart';

class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? address;
  final String? phone;

  const UserAvatar({
    Key? key,
    this.imageUrl,
    this.name,
    this.address,
    this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                SizedBox(
                  height: 65,
                  width: 65,
                  child: ClipOval(
                    child: Image.network(imageUrl ??
                        'https://inanh.net/wp-content/uploads/2020/07/chup-anh-chan-dung-dep-4.png'),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 12,
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: ClipOval(
                      child: Container(
                        color: Colors.white,
                        child: const Icon(
                          Icons.camera_alt,
                          size: 16,
                          color: kF2F4B4E,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? "Chưa cập nhật...",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: kMainDarkColor),
                ),
                const SizedBox(
                  height: 4,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Địa chỉ: ",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: kMainDarkColor),
                      ),
                      TextSpan(
                        text: address ??
                            "Chưa cập nhật địa chỉ giao hàng...",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 1.4,
                            color: kMainDarkColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Số điện thoại: ",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: kMainDarkColor),
                      ),
                      TextSpan(
                        text: phone ?? "Chưa cập nhật...",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: kMainDarkColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
