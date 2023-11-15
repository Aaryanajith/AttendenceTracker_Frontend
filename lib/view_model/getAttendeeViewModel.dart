// ignore_for_file: file_names

import 'dart:async';
import 'package:attendencetracker/model/getAttendees_model.dart';
import 'package:flutter/material.dart';
import 'package:attendencetracker/repositories/getAttendee_repository.dart';

class GetAttendeeViewModel with ChangeNotifier {
  final _attendeeData = GetAttendeeRepository();

  Future<List<GetAttendees>?> getAttendeeApi(
      dynamic data, BuildContext context) async {
        final value = await _attendeeData.getAttendee(data);

      if (value is List) {
        List<GetAttendees> attendeeList = value
            .map((attendee) => GetAttendees.fromJson(attendee))
            .toList();

        debugPrint("The big response is here $value");

        return attendeeList;
      } else {
        return null;
    }
  }
}
