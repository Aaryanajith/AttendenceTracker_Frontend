import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:attendencetracker/utlities/routes/route.dart';
import 'package:attendencetracker/view_model/eventViewModel.dart';
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
        ChangeNotifierProvider(create: (_) => EventViewModel())
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: RouteNames.login,
      onGenerateRoute: Routes.generateRoute,
    ),
    );
  }
}
