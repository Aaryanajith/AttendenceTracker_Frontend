import 'package:flutter/material.dart';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getPostApiResponse_(String url, dynamic headers, dynamic data, BuildContext context);
  Future<dynamic> getDeleteApiResponse(String url);
}
