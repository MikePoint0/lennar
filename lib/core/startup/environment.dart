
import 'dart:io';

import 'package:lennar/core/config/config.dart';
import 'package:lennar/core/network/keys.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';

setupConfig() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  AppConfig.version = packageInfo.version;
  AppConfig.environment = Environment.staging;
  ApiConstants();

}
