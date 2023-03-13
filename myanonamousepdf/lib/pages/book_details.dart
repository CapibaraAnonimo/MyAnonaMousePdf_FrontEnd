import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myanonamousepdf/blocs/book_details/book_details.dart';
import 'package:myanonamousepdf/config/locator.dart';
import 'package:myanonamousepdf/models/book.dart';
import 'package:myanonamousepdf/services/services.dart';

class BookDetails extends StatelessWidget {
  String id;

  BookDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final authService = getIt<JwtAuthenticationService>();

    return BlocProvider<BookDetailsBloc>(
      create: (context) => BookDetailsBloc(authService),
      child: BlocBuilder<BookDetailsBloc, BookDetailsState>(
        builder: (context, state) {
          final _bookBloc = BlocProvider.of<BookDetailsBloc>(context);

          return Scaffold(appBar: AppBar(), body: BookDetailsBody(id: id));
        },
      ),
    );
  }
}

class BookDetailsBody extends StatelessWidget {
  String id;

  BookDetailsBody({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final authService = getIt<JwtAuthenticationService>();

    return BlocProvider<BookDetailsBloc>(
        create: (context) => BookDetailsBloc(authService),
        child: BlocBuilder<BookDetailsBloc, BookDetailsState>(
            builder: (context, state) {
          final _bookBloc = BlocProvider.of<BookDetailsBloc>(context);
          if (state is BookDetailsInitial) {
            _bookBloc.add(GetData(id: id));
          } else if (state is BookDetailsLoading) {
            return const CircularProgressIndicator();
          } else if (state is BookDetailsSuccess) {
            BookResponse book = state.book;
            return Column(
              children: [
                Text(book.title, style: TextStyle(color: Colors.white)),
                Text(book.author, style: TextStyle(color: Colors.white)),
                Text(book.category, style: TextStyle(color: Colors.white)),
                Text(book.description, style: TextStyle(color: Colors.white)),
                Text(book.amountDownloads.toString(), style: TextStyle(color: Colors.white)),
              ],
            );
          } else if (state is BookDetailsFailure) {}
          return const Text(
            'No deberia de llegar a aqui',
            style: TextStyle(fontSize: 40),
          );
        }));
  }
}
