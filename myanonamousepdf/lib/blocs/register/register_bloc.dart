import 'package:bloc/bloc.dart';
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
    //TODO hacer el metodo de registro
  }
}
