import 'package:flutter/widgets.dart';

class AuthUser {
  final String uid;
  final String displayName;
  final String email;

  AuthUser({
    @required this.uid,
    @required this.displayName,
    @required this.email,
  });

  bool get isGuest => email == null || email.isEmpty;

  @override
  String toString() {
    return '$displayName';
  }
}
