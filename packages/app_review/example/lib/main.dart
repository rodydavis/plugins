import 'package:app_review/app_review.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AppReview.getAppID.then((String onValue) {
      setState(() {
        appID = onValue;
      });
      print("App ID" + appID);
    });
  }

  String appID = "";
  String output = "";

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(title: const Text('App Review')),
        body: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Container(
                height: 40.0,
              ),
              new ListTile(
                leading: const Icon(Icons.info),
                title: const Text('App ID'),
                subtitle: new Text(appID),
                onTap: () {
                  AppReview.getAppID.then((String onValue) {
                    setState(() {
                      output = onValue;
                    });
                    print(onValue);
                  });
                },
              ),
              const Divider(height: 20.0),
              new ListTile(
                leading: const Icon(
                  Icons.shop,
                ),
                title: const Text('View Store Page'),
                onTap: () {
                  AppReview.storeListing.then((String onValue) {
                    setState(() {
                      output = onValue;
                    });
                    print(onValue);
                  });
                },
              ),
              const Divider(height: 20.0),
              new ListTile(
                leading: const Icon(
                  Icons.star,
                ),
                title: const Text('Request Review'),
                onTap: () {
                  AppReview.requestReview.then((String onValue) {
                    setState(() {
                      output = onValue;
                    });
                    print(onValue);
                  });
                },
              ),
              const Divider(height: 20.0),
              new ListTile(
                leading: const Icon(
                  Icons.note_add,
                ),
                title: const Text('Write a New Review'),
                onTap: () {
                  AppReview.writeReview.then((String onValue) {
                    setState(() {
                      output = onValue;
                    });
                    print(onValue);
                  });
                },
              ),
              const Divider(height: 20.0),
              new ListTile(title: new Text(output)),
            ],
          ),
        ),
      ),
    );
  }
}
