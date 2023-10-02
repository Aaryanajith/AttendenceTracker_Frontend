// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:attendencetracker/data/exceptions.dart';
import 'package:attendencetracker/data/network/BaseApiServices.dart';
import 'package:http/http.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic resposneJson;
    try {
      // final response =
      //     await get(Uri.parse(uri)).timeout(const Duration(seconds: 10));
      // resposneJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return resposneJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic resposneJson;
    try {
      Response response =
          await post(Uri.parse(url), body: data).timeout(const Duration(seconds: 10));
      resposneJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return resposneJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorizedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error Occured while communicating with server : status code${response.statusCode}');
    }
  }
}
