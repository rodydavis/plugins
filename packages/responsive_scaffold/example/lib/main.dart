import 'package:flutter/material.dart';

import 'package:responsive_scaffold/responsive_scaffold.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ResponsiveScaffold.builder(
        scaffoldKey: _scaffoldKey,
        detailBuilder: (BuildContext context, int index, bool tablet) {
          return DetailsScreen(
            // appBar: AppBar(
            //   elevation: 0.0,
            //   title: Text("Details"),
            //   actions: [
            //     IconButton(
            //       icon: Icon(Icons.share),
            //       onPressed: () {},
            //     ),
            //     IconButton(
            //       icon: Icon(Icons.delete),
            //       onPressed: () {
            //         if (!tablet) Navigator.of(context).pop();
            //       },
            //     ),
            //   ],
            // ),
            body: Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                automaticallyImplyLeading: !tablet,
                title: Text("Details"),
                actions: [
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      if (!tablet) Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                elevation: 0.0,
                child: Container(
                  child: IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {},
                  ),
                ),
              ),
              body: Container(
                child: Center(
                  child: Text("Item: $index"),
                ),
              ),
            ),
          );
        },
        nullItems: Center(child: CircularProgressIndicator()),
        emptyItems: Center(child: Text("No Items Found")),
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
        bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          child: Container(
            child: IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text("Snackbar!"),
            ));
          },
        ),
      ),
    );
  }
}
