import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:attendencetracker/utlities/routes/route.dart';
import 'package:attendencetracker/view_model/authViewModel.dart';
import 'package:attendencetracker/view_model/createEventModel.dart';
import 'package:attendencetracker/view_model/deleteEventViewModel.dart';
import 'package:attendencetracker/view_model/getAttendeeViewModel.dart';
import 'package:attendencetracker/view_model/getEventViewModel.dart';
import 'package:attendencetracker/view_model/scanAttendeeModel.dart';
import 'package:attendencetracker/view_model/tokenViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => EventViewModel()),
        ChangeNotifierProvider(create: (_) => TokenViewModel()),
        ChangeNotifierProvider(create: (_) => CreateEventModel()),
        ChangeNotifierProvider(create: (_) => DeleteEventModel()),
        ChangeNotifierProvider(create: (_) => ScanAttendeeModel()),
        ChangeNotifierProvider(create: (_) => GetAttendeeViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: RouteNames.details,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
