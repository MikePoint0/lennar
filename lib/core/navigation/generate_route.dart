import 'package:lennar/core/navigation/keys.dart';
import 'package:flutter/material.dart';
import 'package:lennar/screens/details/details.dart';
import 'package:lennar/screens/home/home.dart';
import 'package:lennar/screens/login/root.dart';
import '../../screens/splash/root.dart';

Route generateRoute(RouteSettings settings) {
  String routeName = settings.name ?? '';

  switch (routeName) {
    case RouteKeys.routeSplash:
      return MaterialPageRoute(builder: (_) => SplashScreen());
    case RouteKeys.routeLoginScreen:
      return MaterialPageRoute(builder: (_) => LoginScreen());
    case RouteKeys.routeHome:
      return MaterialPageRoute(builder: (_) => HomeScreen());
    case RouteKeys.routeDetails:
      Map? args = settings.arguments as Map?;
      return MaterialPageRoute(builder: (_) => DetailsScreen(
          args?['imageUrl']
      ));
    default:
      return MaterialPageRoute(
          builder: (_) => _ErrorScreen(routeName: routeName));
  }
}

class _ErrorScreen extends StatelessWidget {
  final String routeName;
  const _ErrorScreen({Key? key, required this.routeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Route '$routeName' does not exist"),
      ),
    );
  }
}
