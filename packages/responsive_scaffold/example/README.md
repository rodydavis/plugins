# responsive_scaffold_example

Demonstrates how to use the responsive_scaffold plugin.

``` dart
import 'package:flutter/material.dart';

import 'package:responsive_scaffold/responsive_scaffold.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ResponsiveScaffold.builder(
        detailBuilder: (BuildContext context, int index) {
          return DetailsScreen(
            appBar: AppBar(
              elevation: 0.0,
              title: Text("Details"),
              actions: [
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {},
                ),
              ],
            ),
            body: Container(
              child: Center(
                child: Text("Item: $index"),
              ),
            ),
          );
        },
        slivers: <Widget>[
          SliverAppBar(
            title: Text("App Bar"),
          ),
        ],
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(index.toString()),
          );
        },
      ),
    );
  }
}

```