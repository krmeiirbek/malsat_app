import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malsat_app/bloc/auth_bloc/auth.dart';
import 'package:malsat_app/repositories/repositories.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc(this.authRepository, this.authenticationBloc)
      : assert(authRepository != null),
        assert(authenticationBloc != null),
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await authRepository.login(event.email, event.password);
        authenticationBloc.add(LoggedIn(token: token));
        yield LoginInitial();
      } catch (e) {
        yield LoginFailure(error: e.toString());
      }
    }
  }
}