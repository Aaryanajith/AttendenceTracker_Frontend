import 'package:attendencetracker/repositories/event_repository.dart';
import 'package:flutter/material.dart';

class CreateEventModel with ChangeNotifier {
  final _createEventData = EventRepository();

  Future<void> createEvent(dynamic data, BuildContext context) async {
    _createEventData.createEventApi(data).then((value) {
      debugPrint(value.toString());
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }
}
