part of firestore_api;

class DocumentSnapshot implements FirestoreObject {
  DocumentSnapshot(this.client, this.json);

  /// Reads individual values from the snapshot
  dynamic operator [](String key) => json[key];

  @override
  final FirestoreClient client;

  @override
  final Map<String, dynamic> json;

  /// Gets a [DocumentReference] for the specified Firestore path.
  DocumentReference get reference {
    assert(path != null);
    return DocumentReference(client, path.split('/'));
  }

  /// Returns the ID of the snapshot's document
  String get documentID => path.split('/').last;

  /// Returns `true` if the document exists.
  bool get exists => json != null;

  String get path => json['name'];

  DateTime get dateCreate => json['createTime'];

  DateTime get dateUpdated => json['updateTime'];

  Map<String, dynamic> get data => _getData(json['fields']);
}

Map<String, dynamic> _getData(json) {
  final Map<String, dynamic> _data = {};
  for (var f in json.keys) {
    final _item = json[f];
    _data['$f'] = _getValue(_item);
  }
  return _data;
}

dynamic _getValue(value) {
  final Map map = json.decode(json.encode(value));
  for (String key in map.keys) {
    final _map = json.decode(json.encode(map[key]));
    if (key == 'stringValue') {
      return _map as String;
    } else if (key == 'nullValue') {
      return null;
    } else if (key == 'timestampValue') {
      return DateTime.tryParse(_map);
    } else if (key == 'booleanValue') {
      return _map as bool;
    } else if (key == 'number_value') {
      return num.tryParse(_map.toString());
    } else if (key == 'geoPointValue') {
      return {
        "latitude": num.tryParse(_map['latitude'].toString()),
        "longitude": num.tryParse(_map['longitude'].toString()),
      };
    } else if (key == 'arrayValue') {
      return _getList(_map);
    } else if (key == 'mapValue') {
      return _getData(_map['fields']);
    }
  }

  return map;
}

List<dynamic> _getList(Map<String, dynamic> data) {
  final _list = List.from(data['values']);
  List<dynamic> _items = [];
  for (var item in _list) {
    _items.add(_getValue(item));
  }
  return _items;
}
