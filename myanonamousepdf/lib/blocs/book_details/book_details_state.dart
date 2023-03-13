import 'package:equatable/equatable.dart';
import 'package:myanonamousepdf/models/book.dart';

abstract class BookDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

class BookDetailsInitial extends BookDetailsState {}

class BookDetailsLoading extends BookDetailsState {}

class BookDetailsSuccess extends BookDetailsState {
  final BookResponse book;

  BookDetailsSuccess({required this.book});

  @override
  List<Object> get props => [book];
}

class BookDetailsFailure extends BookDetailsState {
  final String error;

  BookDetailsFailure({required this.error});

  @override
  List<Object> get props => [error];
}
