import 'dart:convert';

import 'package:myanonamousepdf/services/localstorage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:myanonamousepdf/models/models.dart';
import 'package:myanonamousepdf/repositories/repositories.dart';

import '../repositories/BookRepository.dart';

abstract class BookService {
  Future<User?> getCurrentUser();
  Future<List<BookResponse>> getAllBooks();
}

@Order(1)
//@Singleton(as: AuthenticationService)
@singleton
class JwtBookService extends BookService {
  late BookRepository _bookRepository;
  late LocalStorageService _localStorageService;

  JwtBookService() {
    _bookRepository = GetIt.I.get<BookRepository>();
    GetIt.I
        .getAsync<LocalStorageService>()
        .then((value) => _localStorageService = value);
  }

  @override
  Future<User?> getCurrentUser() async {
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
  Future<List<BookResponse>> getAllBooks() async {
    print("Se llega al servicio");
    List<BookResponse> response = await _bookRepository.getAllBooks();
    await _localStorageService.saveToDisk(
        'bookList', jsonEncode(response));
    return response;
  }
}
