import 'package:attendencetracker/resources/app_url.dart';
import 'package:attendencetracker/view/scanner_screen.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';

class ScanRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<QRScanner> markAttendenceApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse_(AppUrl.markAttendence, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
