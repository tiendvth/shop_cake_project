import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/widgets/c_text.dart';

class CButton extends StatefulWidget {
  final double? width;
  final double? height;
  final double? radius;
  final String? title;
  final Color? borderColor;
  final Color? bgColor;
  final double? fontSize;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final VoidCallback? onPressed;
  final bool? checkLoading;

  const CButton(
      {Key? key,
      this.width,
      this.height,
      this.radius,
      this.title,
      this.borderColor,
      this.bgColor,
      this.fontSize,
      this.fontColor,
      this.fontWeight,
      this.fontFamily,
      this.onPressed,
      this.checkLoading})
      : super(key: key);

  @override
  _CButtonState createState() => _CButtonState();
}

class _CButtonState extends State<CButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.width ?? 152,
        height: widget.height ?? 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 20)),
              side: BorderSide(
                  color: widget.borderColor ?? FontColor.colorFFCB05,
                  width: 1),),
          onPressed: widget.onPressed,
          child: widget.checkLoading ?? true
              ? Center(
                  child: CText(
                    text: widget.title,
                    fontSize: widget.fontSize,
                    textColor: widget.fontColor,
                    fontWeight: widget.fontWeight ?? FontWeight.w500,
                    fontFamily: widget.fontFamily,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: JumpingDotsProgressIndicator(
                    fontSize: 24,
                    milliseconds: 300,
                  ),
                ),
        ),
      ),
    );
  }
}
