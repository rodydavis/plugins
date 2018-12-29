import 'package:flutter/material.dart';
import '../utils/pop_up.dart';
import 'package:native_widgets/native_widgets.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  bool _active = false;
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
      body: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            ListTile(
              title: const Text("Loading Indicator..."),
              trailing: NativeLoadingIndicator(),
            ),
            ListTile(
              title: const Text("Switch"),
              trailing: NativeSwitch(
                value: _active,
                onChanged: (bool value) => setState(() => _active = value),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.all(12.0),
            //   child: NativeTextInput(
            //     leading: Icon(Icons.person),
            //     decoration: InputDecoration(labelText: "Input Placeholder"),
            //     // trailing: Icon(Icons.help),
            //   ),
            // ),
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
              items: [
                "Apple",
                "Orange",
                "Pineapple",
                "Cherry",
              ],
              onChanged: (String value) {
                setState(() {
                  _value = value;
                });
              },
            ),
            NativeListTile(
              title: const Text("Power Saver"),
              // subtitle: Text("Puts Device into Low Power Mode"),
              // hideLeadingIcon: true,
              ios: CupertinoListTileData(
                style: CupertinoCellStyle.basic,
              ),
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
            Container(
              padding: const EdgeInsets.all(20.0),
              child: NativeButton(
                child: const Text("Submit"),
                // padding: const EdgeInsets.all(20.0),
                color: Colors.blue,
                onPressed: () => showAlertPopup(
                    context, "Native Dialog", "Button Submitted!"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
