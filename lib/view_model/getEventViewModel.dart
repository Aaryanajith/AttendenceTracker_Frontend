// ignore: file_names
import 'package:attendencetracker/data/response/api_response.dart';
import 'package:attendencetracker/model/getEvent_model.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:flutter/material.dart';
import 'package:attendencetracker/repositories/event_repository.dart';

class EventViewModel with ChangeNotifier {
  final _myData = EventRepository();

  ApiResponse<EventList> eventsList = ApiResponse.loading();

  setEventList(ApiResponse<EventList> response){
    eventsList = response;
    notifyListeners();
  }

  Future<void> eventApi(BuildContext context) async {

    setEventList(ApiResponse.loading());

    _myData.getEventApi().then((value) {
      Utils.flushBarSuccessMessage('Retrieved events', context);
      setEventList(ApiResponse.completed());
      print(value.toString());
    }).onError((error, stackTrace){
      setEventList(ApiResponse.error(error.toString()));
      print(error.toString());
    });
  }

}
