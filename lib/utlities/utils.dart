// ignore_for_file: library_private_types_in_public_api
import 'package:another_flushbar/flushbar.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:attendencetracker/resources/color.dart';
import 'package:flutter/material.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static AppBar appBar(
    String title, {
    List<Widget>? actions,
    bool automaticallyImplyLeading = false,
  }) {
    return AppBar(
      title: Text(title, style: const TextStyle(color: ColorsClass.white)),
      actions: actions,
      backgroundColor: Colors.amber,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: true,
      elevation: 20,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
    );
  }

  static DropdownButton<String> customDropdown({
    required List<String> items,
    required String? selectedValue,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButton<String>(
      value: selectedValue,
      onChanged: onChanged,
      items: items
          .map(
            (value) => DropdownMenuItem(
              value: value,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                child: Text(
                  value,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

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
          backgroundColor: ColorsClass.red,
          messageColor: ColorsClass.black,
          duration: const Duration(seconds: 3),
        )..show(context));
  }

  static void flushBarSuccessMessage(String message, BuildContext context) {
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
          backgroundColor: const Color.fromARGB(223, 94, 255, 0),
          messageColor: ColorsClass.black,
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
  final VoidCallback onQRCodePressed;

  const BottomNavigationBarUtils({
    super.key,
    required this.onTabTapped,
    required this.currentIndex,
    required this.onQRCodePressed,
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
        dotIndicatorColor: Colors.amber,
        unselectedItemColor: const Color.fromARGB(255, 99, 87, 87),
        splashBorderRadius: 50,
        backgroundColor: Colors.amber,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0),
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
        onTap: (index) {
          widget.onTabTapped(index);
          if (index == 1) {
            widget.onQRCodePressed();
          }

          switch (index) {
            case 0:
              Navigator.pushNamed(context, RouteNames.home);
              break;
            // case 1:
            //   Navigator.pushNamed(context, RouteNames.scanner);
            //   break;
            case 2:
              Navigator.pushNamed(context, RouteNames.details);
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
