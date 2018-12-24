import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';

class Page3 extends StatefulWidget {
  @override
  Page3State createState() {
    return new Page3State();
  }
}

class Page3State extends State<Page3> {
  final Map<int, Widget> children = const <int, Widget>{
    0: Text('Midnight'),
    1: Text('Viridian'),
    2: Text('Cerulean'),
  };
  int _selected = 0;

  String _value = "Apple";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NativeAppBar(
        title: const Text("Input Form"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12.0),
            child: NativeTextInput(
              leading: Icon(Icons.person),
              // trailing: Icon(Icons.help),
            ),
          ),
          Container(height: 20.0),
          NativeGroupSelect<int>(
            groupValue: _selected,
            children: children,
            onValueChanged: (int value) {
              setState(() {
                _selected = value;
              });
            },
          ),
          NativeSelection(
            value: _value,
            items: ["Apple", "Orange", "Pineapple", "Cherry"],
            onChanged: (String value) {
              setState(() {
                _value = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
