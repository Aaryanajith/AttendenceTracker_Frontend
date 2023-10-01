import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:attendencetracker/utlities/routes/route.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteNames.home,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
