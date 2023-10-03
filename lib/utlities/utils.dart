// ignore_for_file: library_private_types_in_public_api

import 'package:another_flushbar/flushbar.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:attendencetracker/resources/color.dart';
import 'package:flutter/material.dart';

class Utils {
  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          flushbarPosition: FlushbarPosition.TOP,
          borderRadius: BorderRadius.circular(10),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          padding: const EdgeInsets.all(15),
          reverseAnimationCurve: Curves.easeInOut,
          icon: const Icon(
            Icons.error,
            size: 28,
            color: Colors.white,
          ),
          message: message,
          backgroundColor: Color.fromARGB(223, 255, 0, 0),
          messageColor: Color.fromARGB(255, 0, 0, 0),
          duration: const Duration(seconds: 3),
        )..show(context));
  }

  static void bottomBarNavigation(String routeName, BuildContext context) {
    Navigator.pushNamed(context, RouteNames.home);
    Navigator.pushNamed(context, RouteNames.scanner);
    Navigator.pushNamed(context, RouteNames.details);
  }

}

class BottomNavigationBarUtils extends StatefulWidget {
  final Function(int) onTabTapped;
  final int currentIndex;

  const BottomNavigationBarUtils({super.key, 
    required this.onTabTapped,
    required this.currentIndex,
  });

  @override
  _BottomNavigationBarUtilsState createState() =>
      _BottomNavigationBarUtilsState();
}

class _BottomNavigationBarUtilsState extends State<BottomNavigationBarUtils> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DotNavigationBar(
        margin: const EdgeInsets.only(left: 10, right: 10),
        currentIndex: widget.currentIndex,
        dotIndicatorColor: Colors.white,
        unselectedItemColor: Colors.grey[300],
        splashBorderRadius: 50,
        onTap: (index) {
          widget.onTabTapped(index);

          switch (index) {
            case 0:
              Utils.bottomBarNavigation(RouteNames.home, context); 
              break;
            case 1:
              Utils.bottomBarNavigation(RouteNames.scanner, context); 
              break;
            case 2:
              Utils.bottomBarNavigation(RouteNames.details, context); 
              break;
          }
        },
        items: [
          DotNavigationBarItem(
            icon: const Icon(Icons.home),
            selectedColor: Colors.purple,
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.qr_code),
            selectedColor: Colors.purple,
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.query_builder),
            selectedColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}

