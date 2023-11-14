// ignore_for_file: file_names

import 'package:attendencetracker/data/network/BaseApiServices.dart';
import 'package:attendencetracker/data/network/NetworkApiServices.dart';
import 'package:attendencetracker/resources/app_url.dart';

class GetAttendeeRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getAttendee(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse_(AppUrl.getAttendees, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
