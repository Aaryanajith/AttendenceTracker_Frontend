// ignore_for_file: file_names

import 'package:attendencetracker/view/services/splashServices.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final SplashServices _splashServices = SplashServices();

  @override 
  void initState(){
    super.initState();

    _splashServices.checkAuth(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
        ),
      ),
    );
  }
}