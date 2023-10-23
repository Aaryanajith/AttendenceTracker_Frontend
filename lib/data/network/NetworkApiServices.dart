// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:attendencetracker/data/exceptions.dart';
import 'package:attendencetracker/data/network/BaseApiServices.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:attendencetracker/view_model/tokenViewModel.dart';
import 'package:provider/provider.dart';
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
      print(e);
      // throw FetchDataException('No Internet Connection');
    }
    return resposneJson;
  }

  @override
  Future getPostApiResponse_(
      String url, dynamic headers, dynamic data, BuildContext context) async {
    final tokenViewModel = Provider.of<TokenViewModel>(context, listen: false);
    dynamic responseJson;

    try {
      // Retrieve the access token from SharedPreferences
      final tokenModel = await tokenViewModel.getToken();
      final String? accessToken = tokenModel.access;
      print(accessToken);

      if (accessToken != null) {
        final headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $accessToken"
        };
        final Response response =
            await post(Uri.parse(url), headers: headers, body: data)
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

  @override
  Future getDeleteApiResponse(String url) async {
    dynamic resposneJson;
    try {
      Response response =
          await delete(Uri.parse(url)).timeout(const Duration(seconds: 10));
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
