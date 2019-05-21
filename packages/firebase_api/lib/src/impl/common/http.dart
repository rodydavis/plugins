library firestore_api.impl.common.http;

import 'dart:async';

import '../../../api.dart';

const String _defaultAppName = "[DEFAULT]";

abstract class FirestoreHttpClient implements FirestoreClient {
  FirestoreHttpClient(
      this.email, this.password, this.app, this.token, this.endpoints);

  @override
  final String email;

  @override
  final String password;

  @override
  final App app;

  @override
  final FirestoreApiEndpoints endpoints;

  @override
  FirestoreAccessToken token;

  bool isCurrentTokenValid(bool refreshable) {
    if (token == null) {
      return false;
    }

    if (refreshable) {
      var now = DateTime.now();
      return token.expiresAt.difference(now).abs().inSeconds >= 60;
    }
    return true;
  }

  @override
  bool get isAuthorized => isCurrentTokenValid(true);

  @override
  Future login() async {
    if (!isCurrentTokenValid(false)) {
      var result = await sendHttpRequest(endpoints.getAuthUrl(app),
          body: {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
          needsToken: false);

      token = FirestoreJsonAccessToken(result, DateTime.now());
      return;
    }

    var result = await sendHttpRequest(endpoints.getRefreshUrl(app),
        body: {
          "grant_type": "refresh_token",
          "refresh_token": token.refreshToken
        },
        needsToken: false);

    token = FirestoreJsonAccessToken(result, DateTime.now());
  }

  @override
  Future<List<DocumentSnapshot>> listDocumentSnapshots(String path) async {
    var list = <DocumentSnapshot>[];

    var result = await getJsonList("$path", extract: 'documents');

    for (var item in result) {
      list.add(new DocumentSnapshot(this, item));
    }

    return list;
  }

  @override
  CollectionReference collection(String path) {
    assert(path != null);
    return CollectionReference(this, path.split('/'));
  }

  @override
  DocumentReference document(String path) {
    assert(path != null);
    return DocumentReference(this, path.split('/'));
  }

  @override
  Future<DocumentSnapshot> getDocumentSnapshot(String path) async {
    final _data = await getJsonMap("$path", extract: null);
    return DocumentSnapshot(this, _asStringKeyedMap(_data));
  }

  Future<Map<String, dynamic>> getJsonMap(String url,
      {Map<String, dynamic> body,
      String extract: "response",
      bool standard: true}) async {
    return (await sendHttpRequest(_apiUrl(url, standard),
        body: body, extract: extract)) as Map<String, dynamic>;
  }

  Future<List<dynamic>> getJsonList(String url,
      {Map<String, dynamic> body,
      String extract: "response",
      bool standard: true}) async {
    return (await sendHttpRequest(_apiUrl(url, standard),
        body: body, extract: extract)) as List<dynamic>;
  }

  Future<dynamic> sendHttpRequest(Uri uri,
      {bool needsToken: true, String extract, Map<String, dynamic> body});

  Uri _apiUrl(String path, bool standard) {
    path = standard ? "$path" : path;
    var uri = endpoints.getFirestoreUrl(app).resolve(path);
    return uri;
  }
}

Map<String, dynamic> _asStringKeyedMap(Map<dynamic, dynamic> map) {
  if (map == null) return null;
  if (map is Map<String, dynamic>) {
    return map;
  } else {
    return Map<String, dynamic>.from(map);
  }
}
