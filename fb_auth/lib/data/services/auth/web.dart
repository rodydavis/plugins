import 'package:firebase/firebase.dart';

import '../../classes/index.dart';

class AuthUtils {
  final _auth = auth();

  Future _setPersistenceWeb(Auth _auth) async {
    try {
      var selectedPersistence = 'local';
      await _auth.setPersistence(selectedPersistence);
    } catch (e) {
      print('_auth.setPersistence -> $e');
    }
  }

  Future<AuthUser> loginGoogle() async {
    throw 'Platform Not Supported';
  }

  Future<AuthUser> login(String username, String password) async {
    await _setPersistenceWeb(_auth);
    try {
      final _result =
          await _auth.signInWithEmailAndPassword(username, password);
      if (_result != null && _result?.user != null) {
        final _user = AuthUser(
          uid: _result.user.uid,
          displayName: _result.user.displayName,
          email: _result.user.isAnonymous ? null : _result.user.email,
        );
        return _user;
      }
    } catch (e) {
      print('FBAuthUtils -> _loginWeb -> $e');
    }
    return null;
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
    await _setPersistenceWeb(_auth);
    try {
      final _result = _auth.currentUser;
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
