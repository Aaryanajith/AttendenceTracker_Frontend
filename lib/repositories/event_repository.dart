import 'package:attendencetracker/data/network/BaseApiServices.dart';
import 'package:attendencetracker/data/network/NetworkApiServices.dart';
import 'package:attendencetracker/resources/app_url.dart';
import 'package:attendencetracker/view_model/getEventViewModel.dart';

class EventRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<EventViewModel> createEventApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.addEvent, data);
      return response = EventViewModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<EventViewModel> getEventApi() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.getEvent);
      return response = EventViewModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<EventViewModel> deleteEventApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.deleteEvent, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }


}
