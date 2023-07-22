import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/widgets/c_image.dart';
import 'package:shop_cake/widgets/space_extention.dart';
class AppbarCartWidget extends StatelessWidget {
  final bool? isShowBack;
  const AppbarCartWidget({Key? key, this.isShowBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                gradient: kBgMenu,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      24, AppBar().preferredSize.height + 15, 24, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (isShowBack == true)
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: kMainDarkColor,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          "Giỏ hàng",
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: kMainDarkColor),
                          ),
                        ),
                      ),
                      const CImage(
                        assetsPath: Assets.icNotification,
                        height: 24,
                        width: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  24, AppBar().preferredSize.height + 70, 24, 0),
              child: Container(
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FontColor.colorFFFFFF,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(
                          0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Giá tiền',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: k514D56,
                            ),
                          ),
                          Text(
                            // text: '${state.totalPrice}',
                            '0đ',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: k514D56,
                            ),
                          ),
                        ],
                      ),
                      5.spaceHeight,
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            // text: '${state.totalPrice}',
                            'Phí giao hàng',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: k514D56,
                            ),
                          ),
                          Text(
                            // text: '${state.totalPrice}',
                            '0đ',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: k514D56,
                            ),
                          ),
                        ],
                      ),
                      5.spaceHeight,
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            // text: '${state.totalPrice}',
                            'Phí dich vụ khác',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: k514D56,
                            ),
                          ),
                          Text(
                            // text: '${state.totalPrice}',
                            '0đ',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: k514D56,
                            ),
                          ),
                        ],
                      ),
                      10.spaceHeight,
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: FontColor.colorBorder,
                      ),
                      10.spaceHeight,
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            // text: '${state.totalPrice}',
                            'Tổng tiền',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: kMainRedColor,
                            ),
                          ),
                          Text(
                            // text: '${state.totalPrice}',
                            '0đ',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: kMainRedColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 60,
        ),
        Center(
          child: Text(
            'Danh sách Giỏ hàng trống',
            style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: k9B9B9B),
          ),
        ),
      ],
    );
  }
}
