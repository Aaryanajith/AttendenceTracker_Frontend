// ignore_for_file: file_names

import 'package:attendencetracker/repositories/event_repository.dart';
import 'package:flutter/material.dart';
import '../utlities/routes/route_names.dart';
import '../utlities/utils.dart';

class CreateEventModel with ChangeNotifier {
  final _createEventData = EventRepository();

  Future<void> createEvent(dynamic data, BuildContext context) async {
    _createEventData.createEventApi(data).then((value) {
      debugPrint(value.toString());
    }).onError((error, stackTrace) {
      Utils.flushBarSuccessMessage("Event Created", context);
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushNamed(context, RouteNames.home);
      });
      debugPrint(error.toString());
    });
  }
}
