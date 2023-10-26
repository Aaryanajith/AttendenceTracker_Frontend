import 'package:attendencetracker/repositories/event_repository.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:flutter/material.dart';

class DeleteEventModel with ChangeNotifier {
  final _deleteEventData = EventRepository();

  Future<void> deleteEvent(dynamic data, BuildContext context) async {
    _deleteEventData.deleteEventApi(data).then((value) {
      Utils.flushBarSuccessMessage("Api Hit", context);
      debugPrint(value.toString());
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }
}
