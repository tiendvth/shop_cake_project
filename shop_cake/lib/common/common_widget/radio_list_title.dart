import 'package:flutter/material.dart';
import 'package:shop_cake/constants/constants.dart';
class RadioListTitleCustom extends StatefulWidget {
  final String? title;
  final GestureTapCallback? onTapSelected;
  final bool? isSelected;
  const RadioListTitleCustom({Key? key, this.title, this.onTapSelected, this.isSelected}) : super(key: key);

  @override
  State<RadioListTitleCustom> createState() => _RadioListTitleCustomState();
}

class _RadioListTitleCustomState extends State<RadioListTitleCustom> {
  bool? _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            widget.onTapSelected?.call(); // Call the provided onTapSelected function
            setState(() {
              if (_isSelected == true) {
                _isSelected = false; // Unselect if already selected
              } else {
                _isSelected = true; // Select if not selected
              }
            });
          },
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: k666666,
                width: 1,
              ),
              color: widget.isSelected == true ? Colors.white : Colors.transparent,
            ),
            child: widget.isSelected == true
                ? Center(
              child: Container(
                width: 12,
                height: 12,
                decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  color: kMainDarkColor.withOpacity(0.5),
                ),
              ),
            )
                : null,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          widget.title!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
