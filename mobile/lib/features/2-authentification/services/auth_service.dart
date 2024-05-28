import 'dart:convert';


import 'package:xcmobile/1-core/api_service.dart';

class AuthService {
  final APIService _apiService = APIService();
  /*Future<AuthResponse> login(String username, String password) async {
    final response = await _apiService.post(apiRoute: "/api/v1/login", body: {
      "username": username.trim(),
      "password": password,
    });
    var body = json.decode(response.body);
    AuthResponse authResponse = AuthResponse.fromJson(body);
    return authResponse;
  }*/

  /*Future<bool> isUserValid(String accessToken) async {
    final response = await _apiService.get(
      apiRoute: "/api/v1/user",
      accessToken: accessToken,
    );
    var body = json.decode(response.body);
    if (body['status'].toString().contains("200")) {
      return true;
    }
    return false;
  }*/
}
