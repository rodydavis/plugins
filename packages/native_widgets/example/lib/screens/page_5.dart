import 'package:native_widgets/native_widgets.dart';
import 'package:flutter/material.dart';
import 'details/details_1.dart';

class Page5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NativeAppBar(
        title: Text("Page 5"),
        ios: CupertinoNavigationBarData(
          heroTag: "List",
          transitionBetweenRoutes: false,
        ),
      ),
    );
  }
}
