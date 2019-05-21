library dart_firebase.impl.browser;

import 'dart:async';
import 'dart:convert';
import 'dart:html';

import '../../api.dart';
import 'common/http.dart';

class FirestoreClientImpl extends FirestoreHttpClient {
  FirestoreClientImpl(String email, String password, App app, FirestoreAccessToken token,
      FirestoreApiEndpoints endpoints)
      : super(email, password, app, token, endpoints);

      

  @override
  Future<dynamic> sendHttpRequest(Uri uri,
      {bool needsToken: true,
      String extract,
      Map<String, dynamic> body}) async {
    var request = new HttpRequest();
    request.open(body == null ? "GET" : "POST", uri.toString());
    if (needsToken) {
      if (!isCurrentTokenValid(true)) {
        await login();
      }
      request.setRequestHeader("Authorization", "Bearer ${token.accessToken}");
    }

    if (body != null) {
      request.setRequestHeader(
          "Content-Type", "application/json; charset=utf-8");
      request.send(const JsonEncoder().convert(body));
    } else {
      request.send();
    }

    await request.onLoadEnd.first;

    var content = request.responseText;
    if (request.status != 200) {
      throw new Exception(
          "Failed to perform action. (Status Code: ${request.status})\n${content}");
    }
    var result = const JsonDecoder().convert(content);

    if (result is! Map) {
      if (extract != null) {
        return result[extract];
      }
    }

    return result;
  }

  @override
  Future close() async {}
}
