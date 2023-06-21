import 'package:flutter/material.dart';
class CategoryItem extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  const CategoryItem({Key? key, this.imageUrl, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red,
        border: Border.all(color: Colors.grey),
      ),
      child:  Column(
        children: [
          Image.network(
            imageUrl ?? '',
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          ),
          Text(
            title ?? '',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
