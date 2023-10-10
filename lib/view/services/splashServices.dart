import 'package:attendencetracker/model/token_model.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:attendencetracker/view_model/tokenViewModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashServices {
  Future<TokenModel> getTokenData() => TokenViewModel().getToken();

  void checkAuth(BuildContext context) async {
    getTokenData().then((value) async {
      print(value.token.toString());

      if (value.token == 'null' || value.token.toString() == '') {
        Future.delayed(const Duration(seconds: 2));
        Navigator.pushNamed(context, RouteNames.login);
      } else {
        Future.delayed(const Duration(seconds: 2));
        Navigator.pushNamed(context, RouteNames.home);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
