import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc.dart';
import '../../../fb_auth.dart';
import '../../classes/auth_user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Function(AuthUser) saveUser, deleteUser;

  AuthBloc({this.saveUser, this.deleteUser});
  @override
  AuthState get initialState => InitialAuthState();
  final _auth = AuthUtils();
  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is CheckUser) {
      yield* _mapCheckToState(event);
    }
    if (event is LoginEvent) {
      yield* _mapLoginToState(event);
    }
    if (event is LogoutEvent) {
      yield* _mapLogoutToState(event);
    }
    if (event is LoginGoogle) {
      yield* _mapGoogleToState(event);
    }
  }

  Stream<AuthState> _mapGoogleToState(LoginGoogle event) async* {
    yield AuthLoadingState();
    final _user = await _auth.loginGoogle();
    if (_user != null) {
      if (saveUser != null) saveUser(_user);
      yield LoggedInState(_user);
    } else {
      yield AuthErrorState('Error login with Google!');
    }
  }

  Stream<AuthState> _mapCheckToState(CheckUser event) async* {
    yield AuthLoadingState();
    final _user = await _auth.currentUser();
    if (_user != null) {
      if (saveUser != null) saveUser(_user);
      yield LoggedInState(_user);
    } else {
      yield LoggedOutState();
    }
  }

  Stream<AuthState> _mapLoginToState(LoginEvent event) async* {
    yield AuthLoadingState();
    final _user = await _auth.login(event.username, event.password);
    if (_user != null) {
      if (saveUser != null) saveUser(_user);
      yield LoggedInState(_user);
    } else {
      yield AuthErrorState('Username or Password Incorrect!');
    }
  }

  Stream<AuthState> _mapLogoutToState(LogoutEvent event) async* {
    yield AuthLoadingState();
    await _auth.logout();
    if (deleteUser != null) deleteUser(event.user);
    yield LoggedOutState();
  }

  static AuthUser currentUser(BuildContext context) {
    final auth = BlocProvider.of<AuthBloc>(context);
    final state = auth.currentState;
    if (state is LoggedInState) {
      return state.user;
    }
    return null;
  }
}
