import 'package:attendencetracker/view/home_screen.dart';
import 'package:attendencetracker/view/scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final argument = settings.arguments;
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());
      case RouteNames.scanner:
        return MaterialPageRoute(builder: (BuildContext context) => Scanner());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No Route Defined'),
            ),
          );
        });
    }
  }
}
