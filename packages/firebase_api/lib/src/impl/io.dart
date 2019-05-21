library firestore_api.impl.io;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../../api.dart';
import 'common/http.dart';

final ContentType _jsonContentType =
    new ContentType("application", "json", charset: "utf-8");

HttpClient _createHttpClient() {
  var client = new HttpClient();
  client.userAgent = "Firestore.dart";
  return client;
}

class FirestoreClientImpl extends FirestoreHttpClient {
  FirestoreClientImpl(String email, String password, App app,
      FirestoreAccessToken token, FirestoreApiEndpoints endpoints,
      {HttpClient client})
      : this.client = client == null ? _createHttpClient() : client,
        super(email, password, app, token, endpoints);

  final HttpClient client;

  @override
  Future<dynamic> sendHttpRequest(Uri uri,
      {bool needsToken: true,
      String extract,
      Map<String, dynamic> body}) async {
    if (endpoints.enableProxyMode) {
      uri = uri.replace(queryParameters: {"__tesla": "api"});
    }

    var request =
        body == null ? await client.getUrl(uri) : await client.postUrl(uri);
    request.headers.set("User-Agent", "Firestore.dart");
    if (needsToken) {
      if (!isCurrentTokenValid(true)) {
        await login();
      }
      request.headers.add("Authorization", "Bearer ${token.accessToken}");
    }
    if (body != null) {
      request.headers.contentType = _jsonContentType;
      request.write(const JsonEncoder().convert(body));
    }
    var response = await request.close();
    var content = await response.transform(const Utf8Decoder()).join();
    if (response.statusCode != 200) {
      throw new Exception(
          "Failed to perform action. $uri (Status Code: ${response.statusCode})\n${content}");
    }
    var result = const JsonDecoder().convert(content);

    if (result is Map) {
      if (extract != null) {
        return result[extract];
      }
    }

    return result;
  }

  @override
  Future close() async {
    await client.close();
  }
}
