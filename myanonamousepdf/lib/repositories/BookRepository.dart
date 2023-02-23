import 'dart:convert';

import 'package:myanonamousepdf/models/login.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:myanonamousepdf/models/models.dart';

import 'package:myanonamousepdf/rest/rest.dart';
import 'package:myanonamousepdf/services/localstorage_service.dart';

@Order(-1)
@singleton
class BookRepository {
  late RestClient _client;
  late LocalStorageService _localStorageService;

  BookRepository() {
    _client = GetIt.I.get<RestClient>();
    GetIt.I
        .getAsync<LocalStorageService>()
        .then((value) => _localStorageService = value);
    //_client = RestClient();
  }

  /*Future<dynamic> doRegister(String username, String password,
      String verifyPassword, String email, String fullName) async {
    String url = '/book';

    var jsonResponse = await _client.get(url);
    return BookResponse.fromJson(jsonDecode(jsonResponse));
  }*/

  Future<dynamic> getAllBooks(int page) async {
    String url = '/book?page=';

    var jsonResponse = await _client.get(url + page.toString());
    Map<String, dynamic> response = jsonDecode(jsonResponse);
    List<dynamic> list = response['content'];
    _localStorageService.saveToDisk('currentPage', response['number']);
    _localStorageService.saveToDisk('maxPages', response['totalPages']);
    List<BookResponse> bookList = [];
    for (var book in list) {
      bookList.add(BookResponse.fromJson(book));
    }
    return bookList;
    //return BookResponse.fromJson(jsonDecode(jsonResponse));
  }
}
