import 'package:equatable/equatable.dart';

import '../../models/models.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  final String username;
  final String password;

  RegisterButtonPressed({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}
