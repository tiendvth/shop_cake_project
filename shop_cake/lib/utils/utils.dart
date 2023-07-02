// File utils
// @project metaxe
// @author phanmanhha198 on 8/2/2022

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/constants/font_size/font_size.dart';

Future<bool?> showToast(message) {
  return Fluttertoast.showToast(
      msg: message.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 14.0);
}

String parserTime(String time) {
  final dateTime = DateTime.parse(time);

  final format = DateFormat('hh:mm  dd-MM-yyyy');
  final timeResult = format.format(dateTime);
  return timeResult;
}

String statusStationString(int status) {
  if (status == 1) {
    return "Đang hoạt động";
  }
  return "Đang đóng cửa";
}

String statusProductString(int status) {
  if (status == 1) {
    return "Sẵn sàng";
  } else if (status == 2) {
    return "Đang cho thuê";
  } else if (status == 3) {
    return "Bảo trì";
  }
  return "Dừng hoạt động";
}

String convertMoney(value) {
  final numberFormat = NumberFormat("###,###,###", "en_US");
  return numberFormat.format(value);
}

showDialogMessage(BuildContext context, String? mess, {checkBack = true}) {
  showDialog(
    context: context,
    barrierDismissible: !checkBack,
    builder: (BuildContext context) {
      return Dialog(
        alignment: Alignment.center,
        backgroundColor: FontColor.colorFFFFFF,
        insetPadding: const EdgeInsets.only(
          left: 36,
          right: 36,
        ),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Thông báo',
                    style: TextStyle(
                        fontSize: FontSize.fontSize_18,
                        fontWeight: FontWeight.w500)),
                Padding(
                    padding: EdgeInsets.only(top: 8), child: Text(mess ?? '')),
                GestureDetector(
                    onTap: () {
                      if (checkBack) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          'Xác nhận',
                          textAlign: TextAlign.end,
                          style: TextStyle(color: FontColor.colorEC222D),
                        ))),
              ],
            )),
      );
    },
  );
}

showDialogMessageConfirm(BuildContext context,  Widget? child,
    {checkBack = true}) {
  showDialog(
    context: context,
    barrierDismissible: !checkBack,
    builder: (BuildContext context) {
      return Dialog(
        alignment: Alignment.center,
        backgroundColor: FontColor.colorFFFFFF,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        insetPadding: const EdgeInsets.only(
          left: 36,
          right: 36,
        ),
        child: child,
      );
    },
  );
}

showDialogConfirm(BuildContext context, String? mess, onClick) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
          alignment: Alignment.center,
          backgroundColor: FontColor.colorFFFFFF,
          insetPadding: EdgeInsets.only(
            left: 36,
            right: 36,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Thông báo',
                    style: TextStyle(
                        fontSize: FontSize.fontSize_20,
                        fontWeight: FontWeight.w500)),
                Padding(
                    padding: EdgeInsets.only(top: 8), child: Text(mess ?? '')),
                Row(
                  children: [
                    Expanded(child: SizedBox()),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          onClick();
                        },
                        child: Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Xác nhận',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: FontColor.colorEC222D,
                                  fontSize: FontSize.fontSize_16),
                            ))),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Hủy',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: FontColor.color212121,
                                fontSize: FontSize.fontSize_16),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ));
    },
  );
}

showDialogConfirmChangeTextAction(
    BuildContext context, String? title, String? mess, onClick) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
          alignment: Alignment.center,
          backgroundColor: FontColor.colorFFFFFF,
          insetPadding: EdgeInsets.only(
            left: 36,
            right: 36,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Thông báo',
                    style: TextStyle(
                        fontSize: FontSize.fontSize_20,
                        fontWeight: FontWeight.w500)),
                Padding(
                    padding: EdgeInsets.only(top: 8), child: Text(mess ?? '')),
                Row(
                  children: [
                    Expanded(child: SizedBox()),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          onClick();
                        },
                        child: Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              title ?? '',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: FontColor.colorEC222D,
                                  fontSize: FontSize.fontSize_16),
                            ))),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Đóng',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: FontColor.color212121,
                                fontSize: FontSize.fontSize_16),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ));
    },
  );
}

Future showLoading(BuildContext context) async {
  return showDialog(
    routeSettings: const RouteSettings(name: "showDialog"),
    barrierDismissible: false,
    context: context,
    useRootNavigator: true,
    builder: (context) => WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Center(
          child: Container(
            color: Colors.black12,
            padding: const EdgeInsets.all(15.0),
            child: Theme(
                data: ThemeData(
                    cupertinoOverrideTheme:
                        const CupertinoThemeData(brightness: Brightness.dark)),
                child: const CupertinoActivityIndicator(
                  radius: 14.5,
                )),
          ),
        ),
      ),
    ),
  );
}

closeLoading(BuildContext context) {
  if (context != null) {
    Navigator.of(context, rootNavigator: true)
        .popUntil((route) => route.settings.name != "showDialog");
  }
}
