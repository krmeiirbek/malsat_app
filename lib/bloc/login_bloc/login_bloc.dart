import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malsat_app/bloc/auth_bloc/auth.dart';
import 'package:malsat_app/repositories/post_repository.dart';
import 'package:malsat_app/repositories/repositories.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthenticationBloc authenticationBloc;
  final PostRepository postRepository;

  LoginBloc(this.authRepository, this.authenticationBloc, this.postRepository)
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
    if (event is RegisterButtonPressed) {
      yield LoginLoading();
      try {
        final token = await authRepository.register(
          event.email,
          event.firstName,
          event.phone,
          event.password,
          event.password2,
        );
        authenticationBloc.add(LoggedIn(token: token));
        yield LoginInitial();
      } catch (e) {
        yield RegisterFailure(error: e.toString());
      }
    }
    if (event is LogOutButtonPressed) {
      authenticationBloc.add(LoggedOut());
    }
    if (event is ChangePasswordButtonPressed) {
      yield LoginLoading();

      try {
        final success = await authRepository.changePassword(
          event.oldPassword,
          event.password,
          event.password2,
        );
        yield ChangePasswordSuccess(success: success);
        yield LoginInitial();
      } catch (e) {
        yield ChangePasswordFailure(error: e.toString());
      }
    }
  }
}
