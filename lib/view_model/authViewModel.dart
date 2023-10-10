// ignore: file_names
// ignore_for_file: use_build_context_synchronously

import 'package:attendencetracker/model/token_model.dart';
import 'package:attendencetracker/repositories/auth_repository.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:attendencetracker/view_model/tokenViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepository = AuthRepository();

  Future<void> login(dynamic data, BuildContext context) async {
    final userPreference = Provider.of<TokenViewModel>(context, listen: false);

    try {
      final value = await _myRepository.login(data);

      final access = value['access']?.toString();
      if (access != null) {
        userPreference.saveToken(TokenModel(access: access));

        Utils.flushBarSuccessMessage('Login Successful', context);
        Navigator.pushNamed(context, RouteNames.home);
      } else {
        Utils.flushBarErrorMessage('Login failed: Access token is missing', context);
      }

      print(value.toString());
    } catch (error) {
      Utils.flushBarErrorMessage('Login failed: Password Wrong', context);
      print(error.toString());
    }
  }
}
