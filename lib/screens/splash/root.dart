
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lennar/core/datasource/key.dart';
import 'package:lennar/core/datasource/local_storage.dart';
import 'package:lennar/core/navigation/keys.dart';
import 'package:lennar/core/navigation/navigation_service.dart';
import 'package:lennar/core/startup/app_startup.dart';
import 'package:lennar/core/utils/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin, WidgetsBindingObserver {

  late bool isFirstTime;
  bool _isLogedin = false;
  String? deviceToken;

  @override
  void initState() {
    super.initState();
    data();
  }

  data() async {
    if (serviceLocator.isRegistered<LocalStorage>()) {
        Future.delayed(const Duration(seconds: 3), () async {
          await _isLogedinCheck();
        });
      }
  }

  Future<bool> _isLogedinCheck() async {
    _isLogedin = (await GetIt.I.get<LocalStorage>().readBool(LocalStorageKeys.kLoginPrefs))!;
    //print("check: "+_isLogedin.toString());
    if (_isLogedin) {
      serviceLocator.get<NavigationService>().replaceWith(RouteKeys.routeHome);
    } else {
      serviceLocator.get<NavigationService>().replaceWith(RouteKeys.routeLoginScreen);
    }
    return _isLogedin;
  }

  Future _checkFirstOpening() async {
    isFirstTime = await GetIt.I.get<LocalStorage>().readBool(LocalStorageKeys.khasOpenedAppBeforeKey) ?? false;
    if (isFirstTime) GetIt.I.get<LocalStorage>().writeBool(LocalStorageKeys.khasOpenedAppBeforeKey, false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50.h),
              child: Image.asset(
                AppAssets.appIcon,
              ),
            ),
          ),
        ],
      )
    );
  }
}
