import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myanonamousepdf/config/locator.dart';
import 'package:myanonamousepdf/models/book.dart';
import '../blocs/book_list/book_list.dart';
import '../services/services.dart';
import 'dart:math' as math;
import 'pages.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = getIt<JwtAuthenticationService>();

    return BlocProvider<BookListBloc>(
      create: (context) => BookListBloc(authService),
      child: Scaffold(
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
        ),
        body: BlocProvider<BookListBloc>(
          create: (context) => BookListBloc(authService),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 60, bottom: 16, left: 16, right: 16),
            child: BlocBuilder<BookListBloc, BookListState>(
              builder: (context, state) {
                final _bookBloc = BlocProvider.of<BookListBloc>(context);
                _bookBloc.add(Loading());
                if (state is BookListSuccess) {
                  List<BookResponse> books = state.books;
                  List<Cards> booksWidget = [];
                  for (var book in books) {
                    booksWidget.add(Cards(
                      book: book,
                    ));
                  }
                  return Column(
                    children: [
                      ...booksWidget,
                    ],
                  );
                } else {
                  return const Text('data');
                }
              },
            ),
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
    return Column(
      children: [
        Card(
          child: Row(children: [
            Image.network(
              'https://innovating.capital/wp-content/uploads/2021/05/vertical-placeholder-image.jpg',
              width: 50,
            ),
            Column(
              children: [Text(book.title!)],
            )
          ]),
        )
      ],
    );
  }
}
