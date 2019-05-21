part of dart_firebase;

class CollectionReference implements FirestoreReference {
  CollectionReference(this.client, this.pathComponents)
      : _pathComponents = pathComponents;

  final List<String> _pathComponents;

  @override
  final FirestoreClient client;

  @override
  final List<String> pathComponents;

  @override
  bool operator ==(dynamic o) =>
      o is DocumentReference && o.client == client && o.path == path;

  /// ID of the referenced collection.
  String get id => _pathComponents.isEmpty ? null : _pathComponents.last;

  /// For subcollections, parent returns the containing DocumentReference.
  ///
  /// For root collections, null is returned.
  CollectionReference parent() {
    if (_pathComponents.isEmpty) {
      return null;
    }
    return CollectionReference(
      client,
      (List<String>.from(_pathComponents)..removeLast()),
    );
  }

  /// Slash-delimited path representing the database location of this query.
  String get path => _pathComponents.join('/');

  /// This document's given or generated ID in the collection.
  String get documentID => _pathComponents.last;

  /// Returns a `DocumentReference` with the provided path.
  ///
  /// If no [path] is provided, an auto-generated ID is used.
  ///
  /// The unique key generated is prefixed with a client-generated timestamp
  /// so that the resulting list will be chronologically-sorted.
  DocumentReference document([String path]) {
    List<String> childPath;
    if (path == null) {
      final String key = PushIdGenerator.generatePushChildName();
      childPath = List<String>.from(_pathComponents)..add(key);
    } else {
      childPath = List<String>.from(_pathComponents)..addAll(path.split(('/')));
    }
    return DocumentReference(client, childPath);
  }

  Future<List<DocumentSnapshot>> snapshots() async {
    return client.listDocumentSnapshots('$path');
  }
}
