import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text("About"),
              previousPageTitle: "FAQ Screen",
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
        title: Text("About"),
      ),
      body: Container(
        color: Colors.blueGrey,
      ),
    );
  }
}
