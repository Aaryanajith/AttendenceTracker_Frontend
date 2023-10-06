// ignore: file_names
import 'package:flutter/material.dart';
import 'package:attendencetracker/repositories/event_repository.dart';

class EventViewModel with ChangeNotifier {
  final _myData = EventRepository();

  Future<void> EventApi(dynamic data, BuildContext context) async {
    _myData.createEventApi(data).then((value) {}).onError((error, stackTrace){});
  }
}
