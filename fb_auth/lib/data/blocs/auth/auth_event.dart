import 'package:meta/meta.dart';

import '../../classes/index.dart';

@immutable
abstract class AuthEvent {}

class CheckUser extends AuthEvent {}

class LoginEvent extends AuthEvent {
  LoginEvent(this.username, this.password);

  final String username, password;
}

class CreateAccount extends AuthEvent {
  CreateAccount(this.name, this.username, this.password);

  final String name, username, password;
}

class LoginGoogle extends AuthEvent {}

class LogoutEvent extends AuthEvent {
  LogoutEvent(this.user);

  final AuthUser user;
}

class ForgotPassword extends AuthEvent {
  ForgotPassword(this.email);

  final String email;
}

class EditName extends AuthEvent {
  EditName(this.name);

  final String name;
}
