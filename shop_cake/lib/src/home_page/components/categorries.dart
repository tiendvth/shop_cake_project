import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/constants.dart';

class Categories extends StatefulWidget {
  final GestureTapCallback? onTap;
  final String? title;

  const Categories({
    Key? key,
    this.onTap,
    this.title,
  }) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: const BoxDecoration(
            color: kMainColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
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
                  widget.title.toString(),
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: kMainDarkColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Widget buildCategory(int index) {
//   return GestureDetector(
//     onTap: () {
//       setState(() {
//         selectedIndex = index;
//       });
//     },
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         decoration: BoxDecoration(
//           color: selectedIndex == index ? kMainDarkColor : kMainColor,
//           borderRadius: const BorderRadius.all(
//             Radius.circular(12),
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // SvgPicture.asset(
//             //   "assets/icons/${categories[index]}.svg",
//             //   color: selectedIndex == index ? Colors.white : kTextColor,
//             // ),
//             Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: Text(
//                 categories[index],
//                 style: GoogleFonts.roboto(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w700,
//                   color:
//                       selectedIndex == index ? kMainWhiteColor : kTextColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
}
