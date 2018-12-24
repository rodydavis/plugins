import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';

class Page3 extends StatelessWidget {
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
        ],
      ),
    );
  }
}
