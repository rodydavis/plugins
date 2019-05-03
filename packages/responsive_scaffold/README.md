[![Buy Me A Coffee](https://img.shields.io/badge/Donate-Buy%20Me%20A%20Coffee-yellow.svg)](https://www.buymeacoffee.com/rodydavis)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=WSH3GVC49GNNJ)

# responsive_scaffold

On mobile it shows a list and pushes to details and on tablet it shows the List and the selected item.

## Getting Started

* You can use this in two modes `ResponsiveScaffold` and `ResponsiveScaffold.builder`.
* On Mobile the ListView will push to the details screen

![mobile](https://github.com/AppleEducate/plugins/blob/master/packages/responsive_scaffold/screenshots/mobile.png)

![push](https://github.com/AppleEducate/plugins/blob/master/packages/responsive_scaffold/screenshots/push.png)

* On Tablet it will show a Master Detail View.

![tablet](https://github.com/AppleEducate/plugins/blob/master/packages/responsive_scaffold/screenshots/tablet.png)

* You can add additional Slivers to the Scrollview and the AppBar is optional.

## Example

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