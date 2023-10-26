import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lennar/core/utils/helpers.dart';

import '../config/config.dart';

class UserInteraction {
  UserInteraction._();
  static DateTime? _lastinteractionTime;

  static UserInteraction get it => UserInteraction._();

  void checkLastInteraction() {
    //if (kDebugMode) return;
    FocusManager.instance.primaryFocus?.unfocus();
    checkUserActivity();
  }

  void checkUserActivity() {
    _lastinteractionTime ??= DateTime.now();
    int differenceInMinutes =
        DateTime.now().difference(_lastinteractionTime!).inMinutes;
    int timeOutTime = AppConfig.environment == Environment.dev ? 60 : 5; //minutes
    if (differenceInMinutes >= timeOutTime) {
      //soft logout
      softLogout();
      showToast("logged_out".tr(), "error");
    } else {
      _lastinteractionTime = DateTime.now();
    }
  }
}
