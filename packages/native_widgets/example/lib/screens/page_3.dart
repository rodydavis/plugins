import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';

class Page3 extends StatefulWidget {
  @override
  Page3State createState() {
    return new Page3State();
  }
}

class Page3State extends State<Page3> {
  int _selected = 0;
  String _value = "Apple";
  bool _switch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NativeAppBar(
        leading: NativeButton(
          child: Text("Cancel"),
          onPressed: () {},
        ),
        title: const Text("Input Form"),
        actions: <Widget>[
          NativeButton(
            child: Text(
              "Save",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12.0),
            child: NativeTextInput(
              leading: Icon(Icons.person),
              decoration: InputDecoration(labelText: "Input Placeholder"),
              // trailing: Icon(Icons.help),
            ),
          ),
          Container(height: 20.0),
          NativeGroupSelect<int>(
            groupValue: _selected,
            children: <int, Widget>{
              0: Text('Midnight'),
              1: Text('Viridian'),
              2: Text('Cerulean'),
            },
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
          NativeListTile(
            title: Text("Power Saver"),
            // subtitle: Text("Puts Device into Low Power Mode"),
            // hideLeadingIcon: true,
            
            trailing: <Widget>[
              NativeSwitch(
                  value: _switch,
                  onChanged: (bool value) {
                    setState(() {
                      _switch = value;
                    });
                  }),
            ],
          ),
        ],
      ),
      persistentFooterButtons: <Widget>[
        NativeToolBar(
          leading: NativeIconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
          // middle: NativeIconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {},
          // ),
          trailing: NativeIconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
