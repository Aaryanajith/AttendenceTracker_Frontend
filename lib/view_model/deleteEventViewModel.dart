// ignore_for_file: file_names

import 'package:attendencetracker/repositories/event_repository.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:flutter/material.dart';
import '../utlities/routes/route_names.dart';

class DeleteEventModel with ChangeNotifier {
  final _deleteEventData = EventRepository();

  Future<void> deleteEvent(dynamic data, BuildContext context) async {
    _deleteEventData.deleteEventApi(data).then((value) {
      debugPrint(value.toString());
    }).onError((error, stackTrace) {
      Utils.flushBarSuccessMessage("Event Deleted", context);
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushNamed(context, RouteNames.home);
      });
      debugPrint(error.toString());
    });
  }
}
