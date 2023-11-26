// ignore_for_file: use_build_context_synchronously, file_names
import 'package:attendencetracker/model/token_model.dart';
import 'package:attendencetracker/repositories/auth_repository.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:attendencetracker/view_model/tokenViewModel.dart';
import 'package:flutter/foundation.dart';
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
        Utils.flushBarErrorMessage(
            'Login failed: Access token is missing', context);
      }

      if (kDebugMode) {
        print(value.toString());
      }
    } catch (error) {
      Utils.flushBarErrorMessage('Login failed: Password Wrong', context);
      debugPrint(error.toString());
    }
  }

  Future<void> refresh(dynamic data, BuildContext context) async {
    final userPreference = Provider.of<TokenViewModel>(context, listen: false);

    try {
      final value = await _myRepository.refresh(data);

      userPreference.removeAccess();

      final access = value['access']?.toString();

      if (access != null) {
        userPreference.saveToken(TokenModel(access: access));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
