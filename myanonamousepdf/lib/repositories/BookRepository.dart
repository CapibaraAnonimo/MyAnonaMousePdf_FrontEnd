import 'dart:convert';

import 'package:myanonamousepdf/models/login.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:myanonamousepdf/models/models.dart';

import 'package:myanonamousepdf/rest/rest.dart';

@Order(0)
@singleton
class BookRepository {
  late RestClient _client;

  BookRepository() {
    _client = GetIt.I.get<RestClient>();
    //_client = RestClient();
  }

  /*Future<dynamic> doRegister(String username, String password,
      String verifyPassword, String email, String fullName) async {
    String url = '/book';

    var jsonResponse = await _client.get(url);
    return BookResponse.fromJson(jsonDecode(jsonResponse));
  }*/

  Future<dynamic> getAllBooks() async {
    String url = '/book';

    print('Se llega al repositorio');
    var jsonResponse = await _client.get(url);
    //Iterable l = json.decode(jsonResponse['content']);
    //return List<BookResponse>.from(l.map((model) => BookResponse.fromJson(model)));
    Map<String, dynamic> response = jsonDecode(jsonResponse);
    List<dynamic> list = response['content'];
    List<BookResponse> bookList = [];
    for (var book in list) {
      bookList.add(BookResponse.fromJson(book));
    }
    return bookList;
    //return BookResponse.fromJson(jsonDecode(jsonResponse));
  }
}
