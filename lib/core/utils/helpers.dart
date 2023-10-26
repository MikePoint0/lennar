import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:lennar/core/datasource/key.dart';
import 'package:lennar/core/datasource/local_storage.dart';
import 'package:lennar/core/navigation/keys.dart';
import 'package:lennar/core/navigation/navigation_service.dart';
import 'package:lennar/core/utils/colors.dart';


void showToast(String msg, String type) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: type == "error" ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

Color getColorHexFromStr(String colorStr) {
  colorStr = "FF" + colorStr;
  colorStr = colorStr.replaceAll("#", "");
  int val = 0;
  int len = colorStr.length;
  for (int i = 0; i < len; i++) {
    int hexDigit = colorStr.codeUnitAt(i);
    if (hexDigit >= 48 && hexDigit <= 57) {
      val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 65 && hexDigit <= 70) {
      // A..F
      val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 97 && hexDigit <= 102) {
      // a..f
      val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
    } else {
      throw FormatException("An error occurred when converting a color");
    }
  }
  return Color(val);
}

logoutDialog(BuildContext contextt, String title, String subTitle) {
  return showDialog<void>(
    context: contextt,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        content: Text(subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0.sp,
              height: 1.2,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
            )),
        actions: <Widget>[
          InkWell(
          onTap: () => Navigator.of(context).pop(false),
          child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.3,
          height: 45,
          alignment: Alignment.center,
          child: Text(
            "no".tr(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0.sp,
              height: 1.2,
              fontWeight: FontWeight.w400,
            ),
          )),
          ),
          InkWell(
          onTap:  () {
            softLogout();
          },
          child: Container(
          color: AppColors.sonaPurple1,
          width: MediaQuery.of(context).size.width * 0.3,
          height: 45,
          alignment: Alignment.center,
          child: Text(
            "yes".tr(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0.sp,
              height: 1.2,
              fontWeight: FontWeight.w400,
            ),
          )),
      ),
        ],
      );
    },
  );
}

void softLogout() {
  GetIt.I.get<LocalStorage>().clearAllExcept(LocalStorageKeys.kLoginEmailPrefs);
  GetIt.I.get<NavigationService>().clearAllTo(RouteKeys.routeLoginScreen);
}


