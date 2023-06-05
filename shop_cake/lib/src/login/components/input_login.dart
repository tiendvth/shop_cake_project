import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputLogin extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool fieldPassword;
  final String? labelText;
  final Widget? prefixIcon;
  final double maxWidth;

  const InputLogin(
      {Key? key,
      this.controller,
      this.hintText,
      this.fieldPassword = false,
      this.labelText,
      this.prefixIcon,
      this.maxWidth = 350})
      : super(key: key);

  @override
  _InputLoginState createState() => _InputLoginState();
}

class _InputLoginState extends State<InputLogin> {
  bool? _obscureText;
  bool close = false;
  final double _sizeIcon = 18.0;

  @override
  void initState() {
    _obscureText = widget.fieldPassword;
    widget.controller?.addListener(listener);
    super.initState();
  }

  listener(){
    if (widget.controller?.text.isEmpty == true) {
      if (close) {
        setState(() {
          close = false;
        });
      }
    } else {
      if (!close) {
        setState(() {
          close = true;
        });
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: widget.maxWidth),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText ?? false,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.greenAccent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            filled: true,
            prefixIcon: widget.prefixIcon,
            fillColor: Colors.white,
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
                : close
                    ? InkWell(
                        onTap: () {
                          widget.controller?.clear();
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                          size: _sizeIcon,
                        ),
                      )
                    : null),
      ),
    );
  }
}
