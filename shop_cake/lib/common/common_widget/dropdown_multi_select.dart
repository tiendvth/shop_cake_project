import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/common/common_widget/model/dropdown_model.dart';

class DropDownWithMultiSelect<T> extends StatefulWidget {
  final List<DropDownModel<T>>? items;
  final Widget? hint;
  final void Function(List<DropDownModel<T>> currentSelectedItems)? onTapItem;
  final VoidCallback? onPressed;
  List<DropDownModel<T>>? _initialItems;

  DropDownWithMultiSelect({
    super.key,
    this.items = const [],
    this.onTapItem,
    this.onPressed,
    this.hint,
    List<DropDownModel<T>>? initialItems,
  }) {
    _initialItems = initialItems ?? [];
  }

  @override
  DropDownWithMultiSelectState<T> createState() =>
      DropDownWithMultiSelectState<T>();
}

class DropDownWithMultiSelectState<T>
    extends State<DropDownWithMultiSelect<T>> {
  // List<DropDownModel<T>> selectedItems = [];

  @override
  void initState() {
    super.initState();
    // selectedItems = widget.initialItems ?? [];
  }

  List<DropdownMenuItem<DropDownModel<T>>> _buildDropDownMenuItem() {
    List<DropdownMenuItem<DropDownModel<T>>> list = widget.items!.map((item) {
      return DropdownMenuItem<DropDownModel<T>>(
        value: item,
        enabled: false,
        child: StatefulBuilder(
          builder: (context, menuSetState) {
            bool isSelected = false;
            for (var element in widget._initialItems!) {
              if (element.id == item.id) {
                isSelected = true;
              }
            }
            return InkWell(
              onTap: () {
                if (isSelected) {
                  widget._initialItems!.remove(item);
                } else {
                  if (item.hasData) {
                    widget._initialItems!.add(item);
                  }
                }
                //This rebuilds the StatefulWidget to update the button's text
                setState(() {});
                //This rebuilds the dropdownMenu Widget to update the check mark
                menuSetState(() {});
                if (widget.onTapItem != null) {
                  widget.onTapItem!.call(widget._initialItems!);
                }
              },
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    isSelected
                        ? const Icon(Icons.check_box_outlined)
                        : const Icon(Icons.check_box_outline_blank),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item.data.toString(),
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }).toList();

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<DropDownModel<T>>(
            isExpanded: true,
            hint: widget.hint ??
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Vui lòng chọn',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                ),
            items: _buildDropDownMenuItem(),
            // icon: Padding(
            //   padding: const EdgeInsets.only(right: 12),
            //   child: Image.asset(
            //     AppImages.icArrowDown,
            //     height: 20,
            //     width: 20,
            //     color: (widget.items != null && widget.items!.isNotEmpty)
            //         ? AppColors.color_000000
            //         : AppColors.color_b5b5b5,
            //   ),
            // ),
            buttonDecoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.transparent),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              color: Colors.transparent,
            ),
            value: widget._initialItems!.isEmpty
                ? null
                : widget._initialItems!.last,
            onChanged: (value) {},
            buttonHeight: 40,
            dropdownMaxHeight: 300,
            itemHeight: 40,
            itemPadding: EdgeInsets.zero,
            selectedItemBuilder: (context) {
              List<T> dataItems = [];
              for (var element in widget._initialItems!) {
                dataItems.add(element.data!);
              }
              return widget.items!.map(
                (item) {
                  return Container(
                    alignment: AlignmentDirectional.centerStart,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      dataItems.join(', '),
                      style: const TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  );
                },
              ).toList();
            },
          ),
        ),
      ),
    );
  }
}
