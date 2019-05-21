import 'package:flutter/material.dart';
import 'package:firestore_api/api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const _app = App(
  apiKey: 'FIREBASE_API_KEY',
  projectId: 'project-id',
);

class _MyHomePageState extends State<MyHomePage> {
  FirestoreClient _client;
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String _username, _password;

  void _login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _setLoding(true);
      final client = FirestoreClient(_username, _password, _app);
      try {
        await client.login();
        if (mounted && client != null) {
          print('token: ${client?.token?.accessToken}');
          _client = client;
        }
      } on Exception catch (e) {
        print(e);
      }
    }
    _setLoding(false);
  }

  void _setLoding(bool value) {
    if (mounted)
      setState(() {
        _loading = value;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(
        builder: (_) {
          if (_client == null || !_client.isAuthorized) {
            return Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration:
                            InputDecoration(filled: true, hintText: 'Username'),
                        onSaved: (val) => _username = val,
                        validator: (val) =>
                            val.isEmpty ? 'Username Required' : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration:
                            InputDecoration(filled: true, hintText: 'Password'),
                        onSaved: (val) => _password = val,
                        validator: (val) =>
                            val.isEmpty ? 'Password Required' : null,
                        obscureText: true,
                      ),
                    ),
                    RaisedButton.icon(
                      icon: Icon(Icons.account_circle),
                      label: Text('Login'),
                      onPressed: _loading ? null : _login,
                    ),
                    if (_loading) ...[CircularProgressIndicator()],
                  ],
                ),
              ),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton.icon(
                  icon: Icon(Icons.people),
                  label: Text('Get Users'),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UsesExample(client: _client),
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class UsesExample extends StatefulWidget {
  UsesExample({
    @required this.client,
  });
  final FirestoreClient client;
  @override
  _UsesExampleState createState() => _UsesExampleState();
}

class _UsesExampleState extends State<UsesExample> {
  @override
  void initState() {
    _getUsers();
    super.initState();
  }

  List<DocumentSnapshot> _users;

  void _getUsers() async {
    final _path = widget.client.collection('users');
    print('Data: ${_path.path} ${_path.pathComponents} ${_path.documentID}');
    final _data = await _path.snapshots();

    if (mounted)
      setState(() {
        _users = _data;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
      ),
      body: Builder(
        builder: (_) {
          if (_users == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (_users.isEmpty) {
            return Center(
              child: Text('No Users Found'),
            );
          }
          return ListView.builder(
            itemCount: _users.length,
            itemBuilder: (_, index) {
              final _item = _users[index];
              return ListTile(
                title: Text(
                    '${_item?.data['first_name'] ?? ''} ${_item?.data['last_name'] ?? ''}'),
                subtitle: Text(_item.data['email']),
              );
            },
          );
        },
      ),
    );
  }
}
