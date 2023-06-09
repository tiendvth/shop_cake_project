import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/widgets/c_image.dart';

import '../../home_page/components/favIcon.dart';

class ItemCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? price;
  final String? imageUrl;
  final GestureTapCallback? onTap;
  final GestureTapCallback? addToCart;

  const ItemCard({
    Key? key,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.onTap,
    this.addToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: kMainGreyColor.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: kMainGreyColor.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CImage(
                    assetsNetworkUrl: imageUrl ??
                        "https://thoidai.com.vn/stores/news_dataimages/thoidai/112017/06/22/chiem-nguong-nhung-chiec-banh-ngot-tinh-te-dep-nhu-thuy-tinh-44-.5835.jpg",
                    height: 150,
                    width: double.infinity,
                    boxFit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      height: 25,
                      width: 60,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            kMainColor,
                            kMainDarkColor,
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.star,
                            color: kMainYellowColor,
                            size: 15,
                          ),
                          Text(
                            "4.8",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Expanded(
                    child: Text(
                     title ?? "Cà phê sữa đá",
                      style:  GoogleFonts.roboto(
                        color: kMainDarkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 4,),
                  const FavIcon(),
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
              height: 6,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      price ?? "20.000đ",
                      style: GoogleFonts.roboto(
                        color: kF2F4B4E,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: addToCart,
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: kFFA6BD,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Thêm",
                              style: GoogleFonts.roboto(
                                color: kMainWhiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Expanded(
                              child: InkWell(
                                child: Icon(
                                  Icons.add,
                                  color: kMainWhiteColor,
                                  size: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
