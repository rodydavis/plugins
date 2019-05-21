part of firestore_api;

abstract class FirestoreObject {
  FirestoreClient get client;
  Map<String, dynamic> get json;
}