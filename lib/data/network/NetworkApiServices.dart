// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';
import 'package:attendencetracker/data/exceptions.dart';
import 'package:attendencetracker/data/network/BaseApiServices.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final userPreference = await SharedPreferences.getInstance();
      final token = userPreference.getString('token');

      final response = await get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
        },
      ).timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic resposneJson;
    try {
      Response response = await post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      resposneJson = returnResponse(response);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // throw FetchDataException('No Internet Connection');
    }
    return resposneJson;
  }

  @override
  Future getPostApiResponse_(String url, dynamic data) async {
    dynamic responseJson;

    try {
      // Retrieve the access token from SharedPreferences
      final userPreference = await SharedPreferences.getInstance();
      final String? accessToken = userPreference.getString('token');
      debugPrint('post with access token request accessed$accessToken');

      if (accessToken != null) {
        final headers = {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json',
          };
        final Response response =
            await post(Uri.parse(url), headers: headers, body: jsonEncode(data))
                .timeout(const Duration(seconds: 10));
        responseJson = returnResponse(response);
      } else {
        throw UnauthorizedException('No Token Found');
      }
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
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
