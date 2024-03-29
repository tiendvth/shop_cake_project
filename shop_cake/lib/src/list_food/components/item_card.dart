import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/widgets/c_image.dart';

import '../../home_page/components/favIcon.dart';

class ItemCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? price;
  final String? priceSale;
  final String? imageUrl;
  final GestureTapCallback? onTap;
  final GestureTapCallback? addToCart;
  final bool? isPromotion;
  final String? promotionSale;
  final bool? isCheckShowPriceSale;
  final bool? isFav;
  final GestureTapCallback? onTapFav;

  const ItemCard({
    Key? key,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.onTap,
    this.addToCart,
    this.promotionSale,
    this.isPromotion = false,
    this.priceSale,
    this.isCheckShowPriceSale,
    this.isFav,
    this.onTapFav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: kMainWhiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kMainGreyColor.withOpacity(0.8)),
          boxShadow: [
            BoxShadow(
              color: k9B9B9B.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image.network(
                        imageUrl ?? "",
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const CImage(
                            assetsPath: Assets.imgDefault,
                            width: double.infinity,
                            height: 150,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                isPromotion == true
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            width: 86,
                            height: 25,
                            decoration: BoxDecoration(
                              gradient: kGradientAppBar,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Assets.icSaleFire,
                                  width: 20,
                                  height: 20,
                                ),
                                Text(
                                  promotionSale ?? '',
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )),
                      )
                    : const SizedBox(),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title ?? "Bánh ngọt tinh tế",
                      style: GoogleFonts.roboto(
                        color: kMainDarkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  FavIcon(
                    onTapFavorite: onTapFav,
                    isFav: isFav,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
              child: Text(
                description ??
                    "Chiêm ngưỡng những chiếc bánh ngọt tinh tế đẹp như thủy tinh.",
                style: GoogleFonts.roboto(
                  color: k9B9B9B,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isCheckShowPriceSale == true
                      ? RichText(
                          text: TextSpan(
                            text: 'Giá: ',
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: price ?? "20.000đ",
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.lineThrough,
                                  color: kMainBlackColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Text(
                          'Giá:',
                          style: GoogleFonts.roboto(
                            color: kMainBlackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      priceSale ?? "20.000đ",
                      style: GoogleFonts.roboto(
                        color: kMainRedColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // Expanded(
                  //   child: InkWell(
                  //     onTap: addToCart,
                  //     child: Container(
                  //       height: 25,
                  //       width: 25,
                  //       decoration: BoxDecoration(
                  //         color: kFFA6BD,
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //       child: Row(
                  //         children: [
                  //           const SizedBox(
                  //             width: 8,
                  //           ),
                  //           Text(
                  //             "Thêm",
                  //             style: GoogleFonts.roboto(
                  //               color: kMainWhiteColor,
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //           const Expanded(
                  //             child: InkWell(
                  //               child: Icon(
                  //                 Icons.add,
                  //                 color: kMainWhiteColor,
                  //                 size: 15,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
