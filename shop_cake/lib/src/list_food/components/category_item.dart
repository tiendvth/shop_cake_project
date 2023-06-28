import 'package:flutter/material.dart';
class CategoryItem extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  const CategoryItem({Key? key, this.imageUrl, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red,
        border: Border.all(color: Colors.grey),
      ),
      child:  Row(
        children: [
          // Image.network(imageUrl ?? '',
          //   height: 40,
          //   width: 40,
          //   fit: BoxFit.cover,
          // ),
          Text(
            title ?? '',
            textAlign: TextAlign.center,

            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.white

            ),
          ),
        ],
      ),
    );
  }
}
