import 'package:equatable/equatable.dart';

import '../../models/models.dart';

abstract class BookListEvent extends Equatable {
  const BookListEvent();

  @override
  List<Object> get props => [];
}

class Loading extends BookListEvent {}

class BookPressed extends BookListEvent {
  final String id;

  BookPressed({required this.id});

  @override
  List<Object> get props => [id];
}
