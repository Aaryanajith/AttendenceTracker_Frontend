import 'package:attendencetracker/data/network/BaseApiServices.dart';
import 'package:attendencetracker/data/network/NetworkApiServices.dart';
import 'package:attendencetracker/model/getAttendees_model.dart';
import 'package:attendencetracker/resources/app_url.dart';

class GetAttendeeRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<GetAttendees> getAttendee(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse_(AppUrl.getAttendes, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
