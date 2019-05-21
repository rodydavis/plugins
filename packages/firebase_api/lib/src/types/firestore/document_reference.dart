part of firestore_api;

class DocumentReference implements FirestoreReference {
  DocumentReference(this.client, this.pathComponents)
      : _pathComponents = pathComponents;

  final List<String> _pathComponents;

  @override
  final FirestoreClient client;

  @override
  final List<String> pathComponents;

    @override
  bool operator ==(dynamic o) =>
      o is DocumentReference && o.client == client && o.path == path;

  /// Slash-delimited path representing the database location of this query.
  String get path => _pathComponents.join('/');

  /// This document's given or generated ID in the collection.
  String get documentID => _pathComponents.last;

  /// Returns the reference of a collection contained inside of this
  /// document.
  CollectionReference collection(String collectionPath) {
    assert(collectionPath != null);
    return CollectionReference(
        client, <String>[path, collectionPath]);
  }

  /// Reads the document referenced by this [DocumentReference].
  ///
  /// If no document exists, the read will return null.
  Future<DocumentSnapshot> get() async {
    return client.getDocumentSnapshot('$path');
  }
}
