import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text("FAQ Screen"),
              previousPageTitle: "More",
            ),
            SliverToBoxAdapter(
              child: Container(
                // color: Colors.purple,
                child: Center(
                  child: CupertinoButton(
                    child: Text("Go To About"),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed("/about");
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ Screen"),
      ),
      body: Container(
        color: Colors.purple,
        child: Center(
          child: FlatButton(
            child: Text("Go To About"),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/about");
            },
          ),
        ),
      ),
    );
  }
}
