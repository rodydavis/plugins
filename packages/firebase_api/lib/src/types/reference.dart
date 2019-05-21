part of firestore_api;

abstract class FirestoreReference {
  FirestoreClient get client;
  List<String> get pathComponents;
}
