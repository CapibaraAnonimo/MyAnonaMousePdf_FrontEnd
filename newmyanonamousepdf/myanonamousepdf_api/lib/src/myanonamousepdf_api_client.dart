import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:myanonamousepdf_api/myanonamousepdf_api.dart';

class LoginRequestFailure implements Exception {
  const LoginRequestFailure() : super();
}

class RegisterRequestFailure implements Exception {
  const RegisterRequestFailure() : super();
}

class MyanonamousepdfApiClient {
  MyanonamousepdfApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final String _baseUrlApi = 'localhost:8080/';

  final http.Client _httpClient;

  Future<JwtUserResponse> login(String auth) async {
    final loginRequest = Uri.http(
      _baseUrlApi,
      'auth/login',
      {},
    );

    final loginResponse = await _httpClient.post(loginRequest, body: auth);

    if (loginResponse.statusCode != 200) {
      throw LoginRequestFailure();
    }

    final jwtUserResponse = jsonDecode(loginResponse.body) as Map;

    return JwtUserResponse.fromJson(loginResponse as Map<String, dynamic>);
  }

  Future<JwtUserResponse> register(String auth) async {
    final registerRequest = Uri.http(
      _baseUrlApi,
      'auth/register',
      {},
    );

    final loginResponse = await _httpClient.post(registerRequest, body: auth);

    if (loginResponse.statusCode != 200) {
      throw RegisterRequestFailure();
    }

    final jwtUserResponse = jsonDecode(loginResponse.body) as Map;

    return JwtUserResponse.fromJson(loginResponse as Map<String, dynamic>);
  }
}
