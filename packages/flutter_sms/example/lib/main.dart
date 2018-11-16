import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_sms/flutter_sms.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _controllerPeople, _controllerMessage;
  String _message, body;
  List<String> people = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    _controllerPeople = TextEditingController();
    _controllerMessage = TextEditingController();
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result =
        await FlutterSms.sendSMS(message: message, recipients: recipents);
    setState(() => _message = _result);
  }

  Widget _phoneTile(String name) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.grey[300]),
            top: BorderSide(color: Colors.grey[300]),
            left: BorderSide(color: Colors.grey[300]),
            right: BorderSide(color: Colors.grey[300]),
          )),
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => setState(() => people.remove(name)),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    name,
                    textScaleFactor: 1.0,
                    style: TextStyle(fontSize: 12.0),
                  ),
                )
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('SMS/MMS Example'),
        ),
        body: ListView(
          children: <Widget>[
            people == null || people.isEmpty
                ? Container(
                    height: 0.0,
                  )
                : Container(
                    height: 90.0,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children:
                            List<Widget>.generate(people.length, (int index) {
                          return _phoneTile(people[index]);
                        }),
                      ),
                    ),
                  ),
            ListTile(
              leading: Icon(Icons.people),
              title: TextField(
                controller: _controllerPeople,
                decoration: InputDecoration(labelText: "Add Phone Number"),
                keyboardType: TextInputType.number,
                onChanged: (String value) => setState(() {}),
              ),
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: _controllerPeople.text.isEmpty
                    ? null
                    : () => setState(() {
                          people.add(_controllerPeople.text.toString());
                          _controllerPeople.clear();
                        }),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.message),
              title: TextField(
                decoration: InputDecoration(labelText: " Add Message"),
                controller: _controllerMessage,
                onChanged: (String value) => setState(() {}),
              ),
              trailing: IconButton(
                icon: Icon(Icons.save),
                onPressed: _controllerMessage.text.isEmpty
                    ? null
                    : () => setState(() {
                          body = _controllerMessage.text.toString();
                          _controllerMessage.clear();
                        }),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.text_fields),
              title: Text(body ?? "No Message Set"),
              subtitle: people == null || people.isEmpty
                  ? null
                  : Text(people.toString()),
              trailing: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if ((people == null || people.isEmpty) &&
                      (body == null || body.isEmpty)) {
                    setState(() =>
                        _message = "At Least 1 Person or Message Required");
                  } else {
                    _sendSMS(body, people);
                  }
                },
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    _message ?? "No Data",
                    maxLines: null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
