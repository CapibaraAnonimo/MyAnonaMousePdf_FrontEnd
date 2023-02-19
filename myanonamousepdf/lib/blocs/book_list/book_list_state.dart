import 'package:equatable/equatable.dart';

abstract class BookListState extends Equatable {
  @override
  List<Object> get props => [];
}

class BookListInitial extends BookListState {}

class BookListLoading extends BookListState {}

class BookListSuccess extends BookListState {}

class BookListFailure extends BookListState {
  final String error;

  BookListFailure({required this.error});

  @override
  List<Object> get props => [error];
}
