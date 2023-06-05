import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  String? image;
  String ? title;
  Label({Key? key, this.image, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image(image: AssetImage(image??'')),
            const SizedBox(width: 8,),
            Expanded(
              child: Text(
                title??'',
                style:const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff514D56),
                ) ,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
