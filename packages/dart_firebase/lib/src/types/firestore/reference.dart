part of dart_firebase;

abstract class FirestoreReference {
  FirestoreClient get client;
  List<String> get pathComponents;
}
