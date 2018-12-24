import 'package:flutter/material.dart';
import '../utils/pop_up.dart';
import 'package:native_widgets/native_widgets.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  bool _active = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NativeAppBar(
        title: const Text("Home"),
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