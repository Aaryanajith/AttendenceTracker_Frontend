import 'package:attendencetracker/data/network/BaseApiServices.dart';
import 'package:attendencetracker/data/network/NetworkApiServices.dart';
import 'package:/attendencetracker/resources/app_url.dart';

class DataRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> dataApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.addEvent, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
