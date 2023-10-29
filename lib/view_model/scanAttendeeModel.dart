// ignore_for_file: file_names

import 'package:attendencetracker/repositories/scan_repository.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:flutter/material.dart';
import '../utlities/routes/route_names.dart';

class ScanAttendeeModel with ChangeNotifier {
  final _scanAttendeeData = ScanRepository();

  Future<void> scanAttendee(dynamic data, BuildContext context) async {
    _scanAttendeeData.markAttendenceApi(data).then((value) {
      debugPrint(value.toString());
      Utils.flushBarSuccessMessage("Att3endence marked", context);
    }).onError((error, stackTrace) {
      Navigator.pushNamed(context, RouteNames.home);
      Utils.flushBarErrorMessage("Attendence not scanned",context);
      debugPrint(error.toString());
    });
  }
}
