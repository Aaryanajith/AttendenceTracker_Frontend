import 'dart:async';

import 'package:attendencetracker/model/getAttendees_model.dart';
import 'package:attendencetracker/repositories/getAttendee_repository.dart';
import 'package:flutter/material.dart';

class GetAttendeeViewModel with ChangeNotifier {
  final _attendeeData = GetAttendeeRepository();

  Future<List<GetAttendees>> getAttendeeApi(dynamic data, BuildContext context) async {
    try {
      final value = await _attendeeData.getAttendee(data);
      debugPrint('The app is done successfully \n $value');
      return [value];
    } catch (error) {
      debugPrint("The app is done but has some problems \n $error");
      rethrow;
    }
  }
}

