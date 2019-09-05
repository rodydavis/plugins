import 'package:meta/meta.dart';

import '../../classes/index.dart';

@immutable
abstract class AuthState {}

class InitialAuthState extends AuthState {}

class LoggedInState extends AuthState {
  LoggedInState(this.user);

  final AuthUser user;
}

class LoggedOutState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  AuthErrorState(this.message);

  final String message;
}
