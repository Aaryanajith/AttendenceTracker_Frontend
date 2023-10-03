import 'package:attendencetracker/utlities/utils.dart';
import 'package:flutter/material.dart';

class Scanner extends StatelessWidget {
  const Scanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            Utils.flushBarErrorMessage('No internet connection', context);
          },
          child: Text('scanner Screen'),
        ),
      ),
    );
  }
}
