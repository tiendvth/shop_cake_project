import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/src/list_food/bloc/list_food_cubit.dart';

class InputSearch extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool fieldPassword;
  final String? labelText;
  final Widget? prefixIcon;
  final double maxWidth;
  final GestureTapCallback? onTap;
  final ListFoodCubit listFoodCubit;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const InputSearch(
      {Key? key,
      this.controller,
      this.hintText,
      this.fieldPassword = false,
      this.labelText,
      this.prefixIcon,
      this.maxWidth = 350,
      required this.listFoodCubit,
      this.onTap,
      this.onChanged,
      this.onSubmitted})
      : super(key: key);

  @override
  _InputSearchState createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  bool? _obscureText;
  final double _sizeIcon = 18.0;

  @override
  void initState() {
    _obscureText = widget.fieldPassword;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 16, left: 16),
      constraints: BoxConstraints(maxWidth: widget.maxWidth),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText ?? false,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kMainDarkColor),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          filled: true,
          prefixIcon: widget.prefixIcon,
          fillColor: Colors.white,
          iconColor: FontColor.color212121,
          hintText: widget.hintText,
          suffixIcon: widget.fieldPassword
              ? _obscureText == true
                  ? InkWell(
                      onTap: () {
                        _obscureText = false;
                        setState(() {});
                      },
                      child: Icon(
                        CupertinoIcons.eye,
                        color: Colors.black,
                        size: _sizeIcon,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        _obscureText = true;
                        setState(() {});
                      },
                      child: Icon(
                        CupertinoIcons.eye_slash,
                        size: _sizeIcon,
                        color: Colors.black,
                      ),
                    )
              : InkWell(
                  onTap: widget.onTap,
                  child: Icon(
                    Icons.filter_list_outlined,
                    color: Colors.grey,
                    size: _sizeIcon,
                  ),
                ),
        ),
        onChanged: (value) {
          widget.onChanged!(value);
        },
        onSubmitted: (value) {
          widget.onSubmitted!(value);
        },
      ),
    );
  }
}
