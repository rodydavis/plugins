# responsive_scaffold_example

Demonstrates how to use the responsive_scaffold plugin.

## Responsive Layout Example

``` dart
import 'package:flutter/material.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';

class LayoutExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: Text('Responsive Layout Example'),
      drawer: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings Page'),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Info Page'),
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('Library Page'),
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help Page'),
          ),
        ],
      ),
      endIcon: Icons.filter_list,
      endDrawer: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.filter_list),
            title: Text('Filter List'),
            subtitle: Text('Hide and show items'),
            trailing: Switch(
              value: true,
              onChanged: (val) {},
            ),
          ),
          ListTile(
            leading: Icon(Icons.image_aspect_ratio),
            title: Text('Size Settings'),
            subtitle: Text('Change size of images'),
          ),
          ListTile(
            title: Slider(
              value: 0.5,
              onChanged: (val) {},
            ),
          ),
          ListTile(
            leading: Icon(Icons.sort_by_alpha),
            title: Text('Sort List'),
            subtitle: Text('Change layout behavior'),
            trailing: Switch(
              value: false,
              onChanged: (val) {},
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.search),
        onPressed: () {},
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {},
      ),
    );
  }
}

```

## Responsive List Example 

``` dart
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
      home: ResponsiveListScaffold.builder(
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
                title: Text("Details"),
                automaticallyImplyLeading: !tablet,
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


```