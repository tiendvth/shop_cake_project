import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/widgets/c_container.dart';

class CTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final Icon? icon;
  final String? imgPath;
  final void Function(String)? onchanged;
  final void Function(String)? onFieldSubmitted;
  final VoidCallback? onComplete;
  final IconButton? suffixIcon;
  final bool? obscureText;
  final Widget? assetImage;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? textInputType;
  final String? initValue;
  final EdgeInsets? contentPadding;
  final String? svgPath;
  final double? height;
  final double? width;
  final Color? borderColor;
  final FocusNode? focusNode;
  final Color? backgroundColor;
  final TextStyle? hintStyle;
  final int? maxLines;
  final TextStyle? style;

  // ignore: use_key_in_widget_constructors
  const CTextFormField(
      {this.controller,
      this.hintText,
      this.labelText,
      this.icon,
      this.imgPath,
      this.onchanged,
      this.suffixIcon,
      this.obscureText,
      this.textInputFormatter,
      this.assetImage,
      this.textInputType,
      this.initValue,
      this.contentPadding,
      this.svgPath,
      this.height,
      this.onFieldSubmitted,
      this.focusNode,
      this.borderColor,
      this.onComplete,
      this.width,
      this.backgroundColor,
      this.hintStyle,
      this.maxLines,
      this.style});

  // factory CTextFormField.telephone({
  //   TextEditingController? controller,
  //   String? hintText,
  //   String? labelText,
  //   Icon? icon,
  //   String? imgPath,
  //   Function(String)? onchanged,
  //   Function(String)? onFieldSubmitted,
  //   IconButton? suffixIcon,
  //   bool? obscureText,
  //   Widget? assetImage,
  //   List<TextInputFormatter>? textInputFormatter,
  //   TextInputType? textInputType,
  //   String? initValue,
  //   EdgeInsets? contentPadding,
  //   String? svgPath,
  //   double? height,
  //   FocusNode? focusNode,
  // }) {
  //   return CTextFormField(
  //     height: 44.h,
  //     controller: controller,
  //     focusNode: focusNode,
  //     svgPath: AssetsSvg.iconSignupTelephone,
  //     imgPath: Assets.iconSignupTelephone,
  //     hintText: hintText,
  //     contentPadding: EdgeInsets.only(top: 13.h, bottom: 13.h),
  //     onchanged: onchanged,
  //     onFieldSubmitted: onFieldSubmitted,
  //     textInputType: TextInputType.number,
  //     textInputFormatter: <TextInputFormatter>[
  //       LengthLimitingTextInputFormatter(10),
  //       FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
  //     ],
  //   );
  // }

  // factory CTextFormField.password({
  //   TextEditingController? controller,
  //   String? hintText,
  //   String? labelText,
  //   Icon? icon,
  //   String? imgPath,
  //   Function(String)? onchanged,
  //   Function(String)? onFieldSubmitted,
  //   IconButton? suffixIcon,
  //   bool? obscureText,
  //   Widget? assetImage,
  //   List<TextInputFormatter>? textInputFormatter,
  //   TextInputType? textInputType,
  //   String? initValue,
  //   EdgeInsets? contentPadding,
  //   String? svgPath,
  //   double? height,
  //   FocusNode? focusNode,
  //   Color? borderColor,
  // }) {
  //   return CTextFormField(
  //     height: 44.h,
  //     controller: controller,
  //     focusNode: focusNode,
  //     borderColor: borderColor ?? FontColor.colorBorder,
  //     svgPath: AssetsSvg.iconSignupLock,
  //     imgPath: Assets.iconSignupLock,
  //     hintText: hintText,
  //     contentPadding: EdgeInsets.only(top: 13.h, bottom: 13.h),
  //     onchanged: onchanged,
  //     onFieldSubmitted: onFieldSubmitted,
  //     suffixIcon: suffixIcon,
  //     obscureText: obscureText,
  //   );
  // }

  @override
  _CTextFormFieldState createState() => _CTextFormFieldState();
}

class _CTextFormFieldState extends State<CTextFormField> {
  @override
  Widget build(BuildContext context) {
    return CContainer(
      width: widget.width ?? double.infinity,
      borderWidth: 1,
      borderColor: widget.borderColor ?? FontColor.colorBorder,
      radius: 10,
      backgroundColor: widget.backgroundColor,
      height: widget.height,
      child: TextFormField(
        initialValue: widget.initValue,
        controller: widget.controller,
        keyboardType: widget.textInputType ?? TextInputType.text,
        inputFormatters: widget.textInputFormatter,
        textInputAction: TextInputAction.next,
        onChanged: widget.onchanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        obscureText: widget.obscureText ?? false,
        onEditingComplete: widget.onComplete,
        maxLines: widget.maxLines,
        validator: (value) {},
        style: widget.style ?? TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: Assets.fontPlusJakartaSans,
          color: FontColor.colorFFFFFF,
        ),
        decoration: InputDecoration(
          icon: widget.icon,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          contentPadding: widget.contentPadding,
          labelText: widget.labelText,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.assetImage,
        ),
      ),
    );
  }
}
