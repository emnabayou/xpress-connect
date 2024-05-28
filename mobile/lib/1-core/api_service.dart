// import 'dart:convert';

import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;
import 'package:xcmobile/1-core/config.dart';
import 'package:xcmobile/1-core/exceptions/no_internet_exception.dart';
import 'package:xcmobile/3-utils/snackbar.dart';

class APIService {
  //final _userAgent = Hive.box("device_info").get("userAgent");
  final Map<String, String> _headers = {
    "Content-type": "application/json",
  };
  Future<http.Response> get(
      {required String apiRoute,
      Map<String, dynamic>? params,
      String? accessToken}) async {
    if (accessToken != null) {
      _headers['authorization'] = "Bearer $accessToken";
    }
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      AppSnackBar()
          .showNotification(title: "Erreur", body: "Aucune connexion internet");
      throw NoInternetException("no internet connection");
    }
    log("fetching $apiRoute");
    try {
      final response = await http
          .get(Uri.http(Configs.xcAPIURL, apiRoute, params),
              headers: _headers)
          .timeout(const Duration(seconds: 50));
      //log("done fetching $apiRoute with status ${response.statusCode},body :${response.body}");
      return response;
    } catch (e, s) {
      log("error in fetching $apiRoute, error : ${e.toString()}");
      debugPrintStack(stackTrace: s);
      throw Exception("Http fetching error");
    }

    //return response;
  }

  Future<http.Response> post(
      {required String apiRoute,
      required Map<String, dynamic> body,
      String? accessToken}) async {
    if (accessToken != null) {
      _headers['authorization'] = "Bearer $accessToken";
    }

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      AppSnackBar()
          .showNotification(title: "Erreur", body: "Aucune connexion internet");
      throw NoInternetException("no internet connection");
    }
    log("posting $apiRoute");
    try {
      final response = await http
          .post(Uri.http(Configs.xcAPIURL, apiRoute),
              body: jsonEncode(body), headers: _headers)
          .timeout(const Duration(seconds: 50));
      log("done posting $apiRoute with status ${response.statusCode},body :${response.body}");
      return response;
    } catch (e) {
      log("error in posting $apiRoute, error : ${e.toString()}");
      throw Exception("Http fetching error");
    }
  }
}
