import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NativeAppBar(
        title: Text("Details"),
        ios: CupertinoNavigationBarData(
          heroTag: "Details",
          transitionBetweenRoutes: false,
        ),
      ),
      body: Container(),
    );
  }
}
