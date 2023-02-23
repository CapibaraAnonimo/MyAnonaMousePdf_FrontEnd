import 'dart:convert';
//import 'dart:developer';

import 'package:myanonamousepdf/services/localstorage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

//import '../exceptions/exceptions.dart';
import 'package:myanonamousepdf/models/models.dart';
import 'package:myanonamousepdf/repositories/repositories.dart';

abstract class AuthenticationService {
  Future<User?> getCurrentUser();
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> register(String username, String password,
      String verifyPassword, String email, String fullName);
  Future<void> signOut();
  Future<int?> getCurrentPage();
  Future<int?> getMaxPages();
}
/*
class FakeAuthenticationService extends AuthenticationService {
  @override
  Future<User?> getCurrentUser() async {
    return null; // return null for now
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(Duration(seconds: 1)); // simulate a network delay

    if (email.toLowerCase() != 'test@domain.com' || password != 'testpass123') {
      throw AuthenticationException(message: 'Wrong username or password');
    }
    return User(name: 'Test User', email: email);
  }

  @override
  Future<void> signOut() async {
    log("logout");
  }
}
*/

@Order(2)
//@Singleton(as: AuthenticationService)
@singleton
class JwtAuthenticationService extends AuthenticationService {
  late AuthenticationRepository _authenticationRepository;
  late LocalStorageService _localStorageService;

  JwtAuthenticationService() {
    _authenticationRepository = GetIt.I.get<AuthenticationRepository>();
    GetIt.I
        .getAsync<LocalStorageService>()
        .then((value) => _localStorageService = value);
  }

  @override
  Future<User?> getCurrentUser() async {
    //_localStorageService..deleteFromDisk("user");
    String? loggedUser = _localStorageService.getFromDisk("user");
    if (loggedUser != null) {
      var user = User.fromJson(jsonDecode(loggedUser));
      return user;
      /*return User(
          id: user.id ?? "",
          name: user.fullName ?? '',
          userName: user.username ?? '',
          createdAt: user.createdAt ?? DateTime.now(),
          avatar: user.avatar,
          accessToken: user.token ?? '');*/
    }
    return null;
  }

  @override
  Future<int?> getCurrentPage() async {
    int currentPage = _localStorageService.getFromDisk("currentPage");
    if (currentPage != null) {
      return currentPage;
    }
    return null;
  }

  @override
  Future<int?> getMaxPages() async {
    int maxPages = _localStorageService.getFromDisk("maxPages");
    if (maxPages != null) {
      return maxPages;
    }
    return null;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    User response = await _authenticationRepository.doLogin(email, password);
    await _localStorageService.saveToDisk(
        'user', jsonEncode(response.toJson()));
    return response;
    /*return User(
          id: response.id ?? "",
          name: response.fullName ?? '',
          userName: response.username ?? '',
          createdAt: response.createdAt ?? DateTime.now(),
          avatar: response.avatar,
          accessToken: response.token ?? '');*/
  }

  @override
  Future<User> register(String username, String password, String verifyPassword,
      String email, String fullName) async {
    print('register: ' + username);
    User response = await _authenticationRepository.doRegister(
        username = username,
        password = password,
        verifyPassword = verifyPassword,
        email = email,
        fullName = fullName);
    await _localStorageService.saveToDisk(
        'user', jsonEncode(response.toJson()));
    return response;
    /*return User(
          id: response.id ?? "",
          name: response.fullName ?? '',
          userName: response.userName ?? '',
          //createdAt: response.createdAt ?? DateTime.now(),
          avatar: response.avatar,
          accessToken: response.token ?? '');*/
  }

  @override
  Future<void> signOut() async {
    await _localStorageService.deleteFromDisk("user");
  }
}
