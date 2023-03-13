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
    final loggedUser = await _myanonamousepdfApiClient.login(auth);

    return repo.JwtUserResponse(
      avatar: loggedUser.avatar,
      createdAt: loggedUser.createdAt,
      fullName: loggedUser.fullName,
      id: loggedUser.id,
      refreshToken: loggedUser.refreshToken,
      token: loggedUser.token,
      userName: loggedUser.userName,
    );
  }
}
