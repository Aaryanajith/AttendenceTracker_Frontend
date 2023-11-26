// ignore_for_file: file_names

import 'package:attendencetracker/model/token_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenViewModel with ChangeNotifier {
  Future<bool> saveToken(TokenModel token) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('token', token.access.toString());
    sharedPreferences.setString('refresh', token.refresh.toString());
    notifyListeners();
    return true;
  }

  Future<TokenModel> getToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString('token');
    return TokenModel(access: token.toString());
  }

    Future<bool> removeAccess() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('token');
    return sharedPreferences.clear();
  }


  Future<bool> remove() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('token');
    sharedPreferences.remove('refresh');
    return sharedPreferences.clear();
  }
}
