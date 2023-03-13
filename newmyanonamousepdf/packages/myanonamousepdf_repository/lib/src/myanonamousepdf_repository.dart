import 'dart:convert';

import 'package:myanonamousepdf_api/myanonamousepdf_api.dart';
import 'package:myanonamousepdf_repository/myanonamousepdf_repository.dart'
    as repo;

class MyanonamousepdfRepository {
  MyanonamousepdfRepository(
      {MyanonamousepdfApiClient? myanonamousepdfApiClient})
      : _myanonamousepdfApiClient =
            myanonamousepdfApiClient ?? MyanonamousepdfApiClient();

  final MyanonamousepdfApiClient _myanonamousepdfApiClient;

  Future<repo.JwtUserResponse> login(String auth) async {
    final response = await _myanonamousepdfApiClient.post('auth/login', auth);

    final loggedUser = repo.JwtUserResponse.fromJson(response);
    return loggedUser;

    /*return repo.JwtUserResponse(
      avatar: loggedUser.avatar,
      createdAt: loggedUser.createdAt,
      fullName: loggedUser.fullName,
      id: loggedUser.id,
      refreshToken: loggedUser.refreshToken,
      token: loggedUser.token,
      userName: loggedUser.userName,
    );*/
  }

  Future<repo.JwtUserResponse> register(String auth) async {
    final response = await _myanonamousepdfApiClient.post('auth/register', auth);

    final registerUser = repo.JwtUserResponse.fromJson(response);
    return registerUser;
  }
}
