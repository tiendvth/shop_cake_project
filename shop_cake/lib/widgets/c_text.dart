import 'package:flutter/material.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/constants/font_size/font_size.dart';

class CText extends StatefulWidget {
  final double? width;
  final GestureTapCallback? tappedText;
  final String? text;
  final EdgeInsets? pin;
  final EdgeInsets? margin;
  final Color? textColor;
  final double? fontSize;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final Color? backgrounColor;
  final TextDecoration? textDecoration;
  final String? fontFamily;
  final double? lineSpacing;
  final TextOverflow? textOverflow;
  final int? maxLine;
  final double? wordSpacing;

  const CText({
    Key? key,
    this.textOverflow,
    this.text,
    this.pin,
    this.margin,
    this.textColor,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.backgrounColor,
    this.textDecoration,
    this.tappedText,
    this.width,
    this.fontFamily,
    this.lineSpacing,
    this.fontStyle,
    this.maxLine,
    this.wordSpacing,
  }) : super(key: key);

  @override
  _CTextState createState() => _CTextState();
}

class _CTextState extends State<CText> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.tappedText,
      child: Container(
        width: widget.width,
        padding: widget.pin ?? const EdgeInsets.all(0),
        margin: widget.margin ?? const EdgeInsets.all(0),
        child: Text(
          (widget.text ?? ''),
          textAlign: widget.textAlign ?? TextAlign.left,
          style: TextStyle(
            fontStyle: widget.fontStyle,
            fontFamily: widget.fontFamily ?? Assets.fontPlusJakartaSans,
            height: widget.lineSpacing ?? 1,
            decoration: widget.textDecoration ?? TextDecoration.none,
            backgroundColor: widget.backgrounColor ?? Colors.transparent,
            fontWeight: widget.fontWeight ?? FontWeight.w400,
            color: widget.textColor ?? FontColor.colorText231F20,
            fontSize: widget.fontSize ?? FontSize.fontSize_14,
            wordSpacing: widget.wordSpacing,
          ),
          overflow: widget.textOverflow,
          maxLines: widget.maxLine,
        ),
      ),
    );
  }
}
