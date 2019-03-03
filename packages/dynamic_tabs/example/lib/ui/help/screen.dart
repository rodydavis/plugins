import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text("Help Screen"),
              previousPageTitle: "More",
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Screen"),
      ),
      body: Container(
        color: Colors.blueGrey,
      ),
    );
  }
}
