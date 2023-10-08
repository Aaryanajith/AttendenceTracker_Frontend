import 'package:attendencetracker/view/create_event.dart';
import 'package:attendencetracker/view/delete_event.dart';
import 'package:attendencetracker/view/details_screen.dart';
import 'package:attendencetracker/view/home_screen.dart';
import 'package:attendencetracker/view/login_screen.dart';
import 'package:attendencetracker/view/scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case RouteNames.scanner:
        return MaterialPageRoute(builder: (BuildContext context) => QRScanner(onQRCodePressed: () {},));
      case RouteNames.details:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DetailScreen());
      case RouteNames.addEvent:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CreateEvent());
      case RouteNames.deleteEvent:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DeleteEvent());
      case RouteNames.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
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
