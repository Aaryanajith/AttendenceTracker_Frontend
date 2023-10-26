import 'package:attendencetracker/data/network/BaseApiServices.dart';
import 'package:attendencetracker/data/network/NetworkApiServices.dart';
import 'package:attendencetracker/data/response/api_response.dart';
import 'package:attendencetracker/model/getEvent_model.dart';
import 'package:attendencetracker/resources/app_url.dart';
import 'package:flutter/material.dart';

class EventRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<EventList> createEventApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse_(AppUrl.addEvent, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse<List<EventList>>> getEventApi() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.getEvent);
      List<dynamic> jsonResponseList = response as List<dynamic>;
      List<EventList> eventList =
          jsonResponseList.map((json) => EventList.fromJson(json)).toList();
      ApiResponse<List<EventList>> apiResponse =
          ApiResponse.completed(eventList);
      debugPrint("response ${apiResponse.data}");
      return apiResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<EventList> deleteEventApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse_(AppUrl.deleteEvent, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
