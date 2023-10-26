// ignore_for_file: file_names

import 'dart:convert';
import 'package:attendencetracker/data/response/api_response.dart';
import 'package:attendencetracker/model/getEvent_model.dart';
import 'package:flutter/material.dart';
import 'package:attendencetracker/repositories/event_repository.dart';


class EventViewModel with ChangeNotifier {
  final _myData = EventRepository();

  ApiResponse<List<EventList>> eventsList = ApiResponse.loading();

  setEventList(ApiResponse<List<EventList>> response) {
    if (response.data != null) {
      for (int i = 0; i < response.data!.length; i++) {
        // debugPrint(response.data![i].toJson().toString());
        // Map<String, dynamic> data =
        //     jsonDecode(response.data![i].toJson().toString());
        // String eventName = data["event_name"];
        // debugPrint(eventName);
      }
    }
  }

  Future<List<String>?> eventApi(BuildContext context) async {
  setEventList(ApiResponse.loading());

  try {
    final value = await _myData.getEventApi();
    setEventList(value);

    String json = jsonEncode(value.data);
    List<Map<String, dynamic>> events = List<Map<String, dynamic>>.from(jsonDecode(json));
    List<String> eventNames = events.map((event) => event['event_name'].toString()).toList();
    debugPrint("JSON Response: $eventNames");
    return eventNames;
  } catch (error) {
    setEventList(ApiResponse.error(error.toString()));
    debugPrint(error.toString());
    return null;
  }
}

}
