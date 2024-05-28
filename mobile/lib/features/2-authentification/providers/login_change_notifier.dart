import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xcmobile/1-core/xc_boxes.dart';
import 'package:xcmobile/3-utils/snackbar.dart';

import 'package:xcmobile/features/2-authentification/services/auth_service.dart';
import 'package:xcmobile/features/2-authentification/views/login_page.dart';
import 'package:xcmobile/features/2-authentification/views/pincode_page.dart';
import 'package:xcmobile/features/3-navigation/navigation_page.dart';

class LoginChangeNotifier extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String _username = "";
  String _password = "";
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  String get username => _username;
  String get password => _password;
  GlobalKey<FormState> get formKey => _formKey;

  setUsername(value) {
    _username = value;
    notifyListeners();
  }

  setPassword(value) {
    _password = value;
    notifyListeners();
  }

  void handleSubmit(context) async {
    if(isLoading){
      return;
    }
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading = true;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 3));
      isLoading = false;
      notifyListeners();
      Navigator.pushNamed(context, PincodePage.route);

    } catch (e, s) {
      log("error :$e");
      debugPrint("stacktrace: $s");
      AppSnackBar()
          .showNotification(title: "Erreur", body: "Something went wrong");
    } finally {
      isLoading = false;
      notifyListeners();
    }

    //notifyListeners();
  }

  void logout(context) {
    XCBoxes.authBox.delete("token");
    Navigator.of(context).pushReplacementNamed(LoginPage.route);
  }
}

final loginChangeNotifer = ChangeNotifierProvider<LoginChangeNotifier>(
  (ref) => LoginChangeNotifier(),
);
