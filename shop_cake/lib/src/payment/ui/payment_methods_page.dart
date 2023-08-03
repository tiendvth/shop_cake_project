import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/constants.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainWhiteColor,
        elevation: 0,
        title: Text(
          'Phương thức thanh toán',
          style: GoogleFonts.roboto(
            color: kMainDarkColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            gradient: kBgMenu
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                'Chọn phương thức thanh toán',
                style: GoogleFonts.roboto(
                  color: kF2F4B4E,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: kMainWhiteColor,
                      border:
                          Border.all(color: kMainGreyColor.withOpacity(0.8)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16),
                          child: Row(
                            children: [
                              Image.asset(
                                Assets.icCard,
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Thanh toán bằng thẻ ngân hàng',
                                      style: GoogleFonts.roboto(
                                        color: kMainDarkColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Thanh toán bằng thẻ ngân hàng',
                                      style: GoogleFonts.roboto(
                                        color: kMainGreyColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Icon(
                                Icons.check_circle,
                                color: kMainDarkColor,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32),
                          child: Divider(
                            height: 1,
                            color: kMainGreyColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 16),
                        //   child: Row(
                        //     children: [
                        //       Text(
                        //         'Vietcombank',
                        //         style: GoogleFonts.roboto(
                        //           color: kMainDarkColor,
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.w600,
                        //         ),
                        //       ),
                        //       const Spacer(),
                        //       Text(
                        //         '**** **** **** 1234',
                        //         style: GoogleFonts.roboto(
                        //           color: kMainDarkColor,
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.w600,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Center(
                          child: Text(
                            'Chưa có thẻ nào được thêm',
                            style: GoogleFonts.roboto(
                              color: kMainDarkGreyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(
                          height: 1,
                          color: kMainGreyColor,
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Thêm thẻ',
                                  style: GoogleFonts.roboto(
                                    color: kMainDarkColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.add_circle_outline,
                                  color: kMainDarkColor,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.icPayShip,
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Thanh toán Khi nhận hàng',
                                style: GoogleFonts.roboto(
                                  color: kMainDarkColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Thanh toán sau khi nhận hàng',
                                style: GoogleFonts.roboto(
                                  color: kMainGreyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.check_circle,
                          color: kMainDarkColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // thêm phương thức thanh toán khác
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
