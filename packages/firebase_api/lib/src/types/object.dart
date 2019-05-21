part of dart_firebase;

abstract class FirestoreObject {
  FirestoreClient get client;
  Map<String, dynamic> get json;
}