import 'package:bloc/bloc.dart';
import 'package:myanonamousepdf/blocs/blocs.dart';
import 'package:myanonamousepdf/models/models.dart';
import 'register_event.dart';
import 'register_state.dart';
import '../authentication/authentication.dart';
import '../../exceptions/exceptions.dart';
import '../../services/services.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationService _authenticationService;

  RegisterBloc(AuthenticationBloc authenticationBloc,
      AuthenticationService authenticationService)
      : assert(authenticationBloc != null),
        assert(authenticationService != null),
        _authenticationBloc = authenticationBloc,
        _authenticationService = authenticationService,
        super(RegisterInitial()) {
    on<RegisterButtonPressed>(__onRegisterButtonPressed);
  }

  __onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      print('ButtonPressed: ' + event.username);
      final user = await _authenticationService.register(event.username,
          event.password, event.verifyPassword, event.email, event.fullName);
      if (user != null) {
        emit(RegisterSuccess());
        await Future.delayed(const Duration(seconds: 5));
        _authenticationBloc.add(UserLoggedIn(user: user));
      } else {
        emit(RegisterFailure(error: 'Something very weird just happened'));
      }
    } on Exception catch (e) {
      emit(RegisterFailure(error: e.toString()));
    }
  }
}
