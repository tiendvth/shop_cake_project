import 'package:flutter/material.dart';
import 'package:shop_cake/constants/constants.dart';

class FavIcon extends StatelessWidget {
  final bool? isFav;
  final GestureTapCallback? onTapFavorite;

   const FavIcon({
    Key? key,
    this.isFav,
    this.onTapFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFavorite,
      child: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: kTextColor.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: isFav == true
            ? const Icon(
                Icons.favorite,
                color: kMainColor,
                size: 15,
              )
            : const Icon(
                Icons.favorite_border,
                color: kMainColor,
                size: 15,
              ),
      ),
    );
  }
}
