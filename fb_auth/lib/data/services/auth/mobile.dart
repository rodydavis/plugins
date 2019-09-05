import 'package:firebase_auth/firebase_auth.dart';

import '../../classes/index.dart';

class AuthUtils {
  final _auth = FirebaseAuth.instance;

  Future<AuthUser> login(String username, String password) async {
    try {
      final _result = await _auth.signInWithEmailAndPassword(
          email: username, password: password);
      if (_result != null && _result?.user != null) {
        final _user = AuthUser(
          uid: _result.user.uid,
          displayName: _result.user.displayName,
          email: _result.user.isAnonymous ? null : _result.user.email,
        );
        return _user;
      }
    } catch (e) {
      print('FBAuthUtils -> _loginMobile -> $e');
    }
    return null;
  }

  Future<AuthUser> loginGoogle() async {
    throw 'Platform Not Supported';
  }

  Future logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('FBAuthUtils -> logout -> $e');
    }
    return null;
  }

  Future<AuthUser> currentUser() async {
    try {
      final _result = await _auth.currentUser();
      if (_result != null) {
        final _user = AuthUser(
          uid: _result.uid,
          displayName: _result.displayName,
          email: _result.isAnonymous ? null : _result.email,
        );
        return _user;
      }
    } catch (e) {
      print('FBAuthUtils -> currentUser -> $e');
    }
    return null;
  }
}
