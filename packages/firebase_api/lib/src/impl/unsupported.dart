library firestore_api.impl.unsupported;

import 'dart:async';

import '../../api.dart';

class FirestoreClientImpl implements FirestoreClient {
  FirestoreClientImpl(String email, String password, App app,
      FirestoreAccessToken token, FirestoreApiEndpoints endpoints) {
    throw "This platform is not supported.";
  }

  @override
  App get app => throw "This platform is not supported.";

  @override
  String get email => throw "This platform is not supported.";

  @override
  String get password => throw "This platform is not supported.";

  @override
  FirestoreAccessToken get token => throw "This platform is not supported.";

  @override
  set token(FirestoreAccessToken token) =>
      throw "This platform is not supported.";

  @override
  bool get isAuthorized => throw "This platform is not supported.";

  @override
  FirestoreApiEndpoints get endpoints =>
      throw "This platform is not supported.";

  @override
  Future<DocumentSnapshot> getDocumentSnapshot(String path) {
    throw "This platform is not supported.";
  }

  @override
  Future<List<DocumentSnapshot>> listDocumentSnapshots(String path) {
    throw "This platform is not supported.";
  }

  @override
  Future login() {
    throw "This platform is not supported.";
  }

  @override
  Future close() {
    throw "This platform is not supported.";
  }

  @override
  String get apiKey => throw "This platform is not supported.";

  @override
  CollectionReference collection(String path) {
    throw "This platform is not supported.";
  }

  @override
  DocumentReference document(String path) {
    throw "This platform is not supported.";
  }
}
