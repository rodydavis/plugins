import '../../classes/index.dart';

class AuthUtils {
  Future<AuthUser> login(String username, String password) async {
    throw 'Platform Not Supported';
  }

  Future logout() async {
    throw 'Platform Not Supported';
  }

  Future<AuthUser> currentUser() async {
    throw 'Platform Not Supported';
  }

   Future<AuthUser> loginGoogle() async {
    throw 'Platform Not Supported';
  }
}
