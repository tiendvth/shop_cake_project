import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/common/badge_widget.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/widgets/c_image.dart';


class UpperBody extends StatefulWidget {
  const UpperBody({Key? key, this.onTap, this.onChanged}) : super(key: key);
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  @override
  State<UpperBody> createState() => _UpperBodyState();
}

class _UpperBodyState extends State<UpperBody> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        gradient: kBgMenu,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPaddin, vertical: kDefaultPaddin),
        child: Column(
          children: [
            const SizedBox(
              height: 56,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    "Trang chủ",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: kMainDarkColor),
                    ),
                  ),
                ),
                Badge(
                  value: '3',
                  child: InkWell(
                    onTap: () {},
                    child: const CImage(
                      assetsPath: Assets.icNotification,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(24),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          cursorColor: kTextColor,
                          // onChanged: (value) {
                          //   listFoodCubit.getListFood(
                          //     value,
                          //     priceFrom,
                          //     priceTo,
                          //   );
                          // },
                          onChanged: widget.onChanged,
                          decoration: InputDecoration(
                            hintText: 'Tìm kiếm sản phẩm',
                            hintStyle: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: kTextColor,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      )),
                ),
              ),
              // InkWell(
              //   child: Container(
              //     height: 35,
              //     width: 35,
              //     decoration: const BoxDecoration(
              //       color: Colors.white,
              //       shape: BoxShape.circle,
              //     ),
              //     child: const Padding(
              //       padding: EdgeInsets.all(6.0),
              //       child: Icon(
              //         Icons.filter_list_rounded,
              //         color: kTextColor,
              //       ),
              //     ),
              //   ),
              //   onTap: widget.onTap,
              //   // onTap: (){
              //   //   print('Tap icon fillter');
              //   //   showDialog(
              //   //     context: context,
              //   //     builder: (context) {
              //   //       return DialogFilter(
              //   //         child: Container(
              //   //           height: 380,
              //   //           decoration: const BoxDecoration(
              //   //             color: Colors.white,
              //   //           ),
              //   //           child: GroupButton(
              //   //             controller: controller,
              //   //             buttons: statePrice.data
              //   //                 .map((e) =>
              //   //             '${FormatPrice.formatPriceToInt(e.priceFrom)} - ${FormatPrice.formatPriceToInt(e.priceTo)}')
              //   //                 .toList(),
              //   //             onSelected: (index, value, isSelected) {
              //   //               widget.priceFrom =
              //   //                   statePrice.data[value].priceFrom;
              //   //               widget.priceTo =
              //   //                   statePrice.data[value].priceTo;
              //   //             },
              //   //             options: GroupButtonOptions(
              //   //               spacing: 8,
              //   //               unselectedTextStyle:
              //   //               GoogleFonts.roboto(
              //   //                 fontSize: 14,
              //   //                 fontWeight: FontWeight.w400,
              //   //                 color: Colors.black,
              //   //               ),
              //   //               groupRunAlignment:
              //   //               GroupRunAlignment.start,
              //   //               unselectedColor: Colors.white,
              //   //               selectedColor: kMainDarkColor,
              //   //               selectedTextStyle: GoogleFonts.roboto(
              //   //                 fontSize: 14,
              //   //                 fontWeight: FontWeight.w400,
              //   //                 color: Colors.white,
              //   //               ),
              //   //               borderRadius:
              //   //               BorderRadius.circular(8),
              //   //               textAlign: TextAlign.center,
              //   //               buttonWidth: MediaQuery.of(context)
              //   //                   .size
              //   //                   .width /
              //   //                   2 -
              //   //                   56,
              //   //               runSpacing: 8,
              //   //               direction: Axis.horizontal,
              //   //             ),
              //   //           ),
              //   //         ),
              //   //         onTap: () {
              //   //           print('tap popup');
              //   //           // listFoodCubit.getListFood(
              //   //           //   searchController.text,
              //   //           //   priceFrom,
              //   //           //   priceTo,
              //   //           // );
              //   //           // Navigator.pop(context);
              //   //         },
              //   //       );
              //   //     },
              //   //   );
              //   // },
              // ),
            ],
          ),
          ],
        ),
      ),
    );
  }
}
