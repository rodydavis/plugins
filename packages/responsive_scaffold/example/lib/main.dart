import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
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
            body: Container(),
          );
        },
        appBar: SliverAppBar(
          title: Text("App Bar"),
        ),
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
