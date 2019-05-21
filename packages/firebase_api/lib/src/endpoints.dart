part of firestore_api;

abstract class FirestoreApiEndpoints {
  factory FirestoreApiEndpoints.standard() {
    return new FirestoreStandardApiEndpoints();
  }

  Uri getFirestoreUrl(App app);
  Uri getAuthUrl(App app);
  Uri getRefreshUrl(App app);
  bool get enableProxyMode;
}

class FirestoreStandardApiEndpoints implements FirestoreApiEndpoints {
  @override
  Uri getFirestoreUrl(App app) => Uri.parse(
      "https://firestore.googleapis.com/v1/projects/${app.projectId}/databases/(${app.name})/documents/");

  @override
  bool get enableProxyMode => false;

  @override
  Uri getAuthUrl(App app) => Uri.parse(
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=${app.apiKey}');

  @override
  Uri getRefreshUrl(App app) => Uri.parse(
      'https://securetoken.googleapis.com/v1/token?key=${app.apiKey}');
}
