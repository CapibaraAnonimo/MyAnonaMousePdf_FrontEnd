import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myanonamousepdf/blocs/authentication/authentication.dart';
import 'package:myanonamousepdf/config/locator.dart';
import 'package:myanonamousepdf/models/book.dart';
import 'package:myanonamousepdf/pages/login_page.dart';
import '../blocs/book_list/book_list.dart';
import '../models/user.dart';
import '../services/services.dart';

class BookListPage extends StatelessWidget {
  BuildContext context;
  final User? user;

  BookListPage({super.key, this.user, required this.context});

  Widget addBook() {
    if (user != null) {
      return IconButton(
        icon: const Icon(Icons.add_circle_outline_outlined),
        onPressed: () {},
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget log(AuthenticationBloc auth) {
    if (user != null) {
      return IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            auth.add(UserLoggedOut());
          });
    } else {
      return IconButton(
          icon: const Icon(Icons.login),
          onPressed: () {
            logIn();
          });
    }
  }

  void logIn() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    final authService = getIt<JwtAuthenticationService>();
    final _authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return BlocProvider<BookListBloc>(
      create: (context) => BookListBloc(authService),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 20, 20, 20),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          title: const Text('Books'),
          actions: [
            addBook(),
            log(_authBloc),
          ],
        ),
        body: BlocProvider<BookListBloc>(
          create: (context) => BookListBloc(authService),
          child: BlocBuilder<BookListBloc, BookListState>(
            builder: (context, state) {
              final _bookBloc = BlocProvider.of<BookListBloc>(context);

              if (state is BookListSuccess) {
                List<BookResponse> books = state.books;
                List<Cards> booksWidget = [];
                for (var book in books) {
                  booksWidget.add(Cards(
                    book: book,
                  ));
                }
                return ListView(
                  children: [
                    ...booksWidget,
                  ],
                );
              } else {
                _bookBloc.add(Loading());
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class ListBooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bookBloc = BlocProvider.of<BookListBloc>(context);
    _bookBloc.add(Loading());
    return Text('data');
  }
}

class Cards extends StatelessWidget {
  final BookResponse book;

  const Cards({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
      child: Card(
        color: Color.fromARGB(255, 32, 32, 32),
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  topLeft: Radius.circular(5),
                ),
                child: Image.network(
                  'https://innovating.capital/wp-content/uploads/2021/05/vertical-placeholder-image.jpg',
                  width: 90,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    book.title!,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    book.author!,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 145, 145, 145),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
