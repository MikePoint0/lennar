import 'package:lennar/core/navigation/keys.dart';
import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  pop() async {
    navigatorKey.currentState!.pop();
  }


  Future clearAllTo(String routeName) async {
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  Future clearAllWithParameter(
      {required String routeName, required Map data}) async {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (route) => route.settings.name == RouteKeys.routeLoginScreen,
        arguments: data);
  }

  Future to(String routeName) async {
    navigatorKey.currentState!.pushNamed(routeName);
  }

  Future toWithPameter({required String routeName, required Map data}) async {
    navigatorKey.currentState!.pushNamed(routeName, arguments: data);
  }

  Future replaceWith(String routeName) async {
    navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

}