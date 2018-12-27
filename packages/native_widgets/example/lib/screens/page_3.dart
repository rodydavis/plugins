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
    return NativeListViewScaffold();
  }
}
