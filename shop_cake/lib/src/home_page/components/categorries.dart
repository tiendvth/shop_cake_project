import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/constants.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = [
    "Bánh Sinh Nhật",
    "Bánh Mỳ",
    "Bánh Kem",
    "Bánh Ngọt",
    "Bánh Mặn",
    "Bánh Trái Cây",
    "Bánh Bông Lan",
    "Bánh Bao",
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
        itemCount: categories.length,
        itemBuilder: (context, index) => buildCategory(index),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: selectedIndex == index ? kMainDarkColor : kMainColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SvgPicture.asset(
              //   "assets/icons/${categories[index]}.svg",
              //   color: selectedIndex == index ? Colors.white : kTextColor,
              // ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  categories[index],
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: selectedIndex == index ? kMainWhiteColor : kTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
