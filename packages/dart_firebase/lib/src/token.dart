part of dart_firebase;

abstract class FirestoreAccessToken {
  String get accessToken;
  String get refreshToken;
  DateTime get createdAt;
  DateTime get expiresAt;

  bool get isExpired => expiresAt.isAfter(new DateTime.now());
}

class FirestoreJsonAccessToken extends FirestoreAccessToken {
  FirestoreJsonAccessToken(this.json, this.createdAt);

  final Map<String, dynamic> json;
  String get displayName => json['displayName'] as String;
  String get email => json['email'] as String;
  String get kind => json['kind'] as String;
  String get localId => json['localId'] as String;
  bool get registered => json['registered'] as bool;
  int get expiresInSeconds => int.tryParse(json["expiresIn"]);

  @override
  String get accessToken => json["idToken"] as String;

  @override
  String get refreshToken => json["refresh_token"] as String;

  @override
  final DateTime createdAt;

  @override
  DateTime get expiresAt =>
      createdAt.add(new Duration(seconds: expiresInSeconds));
}
