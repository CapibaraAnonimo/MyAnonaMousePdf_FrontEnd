import 'dart:convert';

import 'package:myanonamousepdf/repositories/BookRepository.dart';
import 'package:myanonamousepdf/services/localstorage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:myanonamousepdf/models/models.dart';

abstract class BookService {
  Future<List<BookResponse>> getAllBooks();
}

@Order(2)
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
  Future<List<BookResponse>> getAllBooks() async {
    print("Se llega al servicio");
    List<BookResponse> response = await _bookRepository.getAllBooks();
    await _localStorageService.saveToDisk(
        'bookList', jsonEncode(response));
    return response;
  }
}
