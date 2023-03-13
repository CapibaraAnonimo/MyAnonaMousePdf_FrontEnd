import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myanonamousepdf_api/myanonamousepdf_api.dart';

class MyanonamousepdfApiClient {
  MyanonamousepdfApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final String _baseUrlApi = 'localhost:8080/';

  final http.Client _httpClient;

  Future<Map<String, dynamic>> post(String url, String body) async {
    final uri = Uri.http(_baseUrlApi, url);

    final postResponse = await _httpClient.post(uri, body: body);

    return _response(postResponse);
  }

  dynamic _response(http.Response response) {
    //TODO comprobar donde se podruce la excepción cuando no hay internet
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson as Map<String, dynamic>;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson as Map<String, dynamic>;
      case 204:
        return;
      case 400:
        throw BadRequestException(utf8.decode(response.bodyBytes));
      case 401:
        throw AuthenticationException(utf8.decode(response.bodyBytes));
      case 403:
        throw UnauthorizedException(utf8.decode(response.bodyBytes));
      case 404:
        throw NotFoundException(utf8.decode(response.bodyBytes));
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  /*Future<JwtUserResponse> login(String auth) async {
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
  }*/
}

class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message]) : super(message, "");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "");
}

class AuthenticationException extends CustomException {
  AuthenticationException([message]) : super(message, "");
}

class UnauthorizedException extends CustomException {
  UnauthorizedException([message]) : super(message, "");
}

class NotFoundException extends CustomException {
  NotFoundException([message]) : super(message, "");
}
