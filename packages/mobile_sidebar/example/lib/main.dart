import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:mobile_sidebar/mobile_sidebar.dart';

void main() {
  // _setTargetPlatformForDesktop();
  runApp(MyApp());
}

// /// If the current platform is desktop, override the default platform to
// /// a supported platform (iOS for macOS, Android for Linux and Windows).
// /// Otherwise, do nothing.
// void _setTargetPlatformForDesktop() {
//   TargetPlatform targetPlatform;
//   if (Platform.isMacOS) {
//     targetPlatform = TargetPlatform.iOS;
//   } else if (Platform.isLinux || Platform.isWindows) {
//     targetPlatform = TargetPlatform.android;
//   }
//   if (targetPlatform != null) {
//     debugDefaultTargetPlatformOverride = targetPlatform;
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  bool searching = false;
  @override
  Widget build(BuildContext context) {
    bool _loggedIn = false;
    return Scaffold(
      body: MobileSidebar(
        currentIndex: index,
        onTabChanged: (val) {
          if (mounted)
            setState(() {
              index = val;
            });
        },
        isSearching: searching,
        isSearchChanged: (val) {
          if (mounted)
            setState(() {
              searching = val;
            });
        },
        titleBuilder: (context) {
          return FancyTitle(
            title: Text("My Logo"),
            logo: FlutterLogo(),
          );
        },
        accountBuilder: (context) {
          if (_loggedIn) {
            return CircleAvatar(
              child: Icon(Icons.person),
            );
          }
          return FlatButton(
            child: Text("Sign In"),
            onPressed: () {},
          );
        },
        showSearchButton: true,
        tabs: <TabChild>[
          TabChild(
            icon: Icon(Icons.bluetooth),
            title: 'Light Blue',
            builder: (context) => NewScreen(
              color: Colors.lightBlue,
              name: 'Light Blue Screen',
            ),
          ),
          TabChild(
            icon: Icon(Icons.info),
            title: 'Light Green',
            builder: (context) => NewScreen(
              color: Colors.lightGreen,
              name: 'Light Green Screen',
            ),
          ),
          TabChild(
            icon: Icon(Icons.person),
            title: 'Red',
            builder: (context) => NewScreen(
              color: Colors.red,
              name: 'Red Screen',
            ),
          ),
          TabChild(
            icon: Icon(Icons.info),
            title: 'Light Green 3',
            builder: (context) => NewScreen(
              color: Colors.lightGreen,
              name: 'Light Green Screen',
            ),
          ),
          TabChild(
            icon: Icon(Icons.person),
            title: 'Red 3',
            builder: (context) => NewScreen(
              color: Colors.red,
              name: 'Red Screen',
            ),
          ),
          TabChild(
            icon: Icon(Icons.info),
            title: 'Light Green 4',
            builder: (context) => NewScreen(
              color: Colors.lightGreen,
              name: 'Light Green Screen',
            ),
          ),
          TabChild(
            icon: Icon(Icons.person),
            title: 'Red 4',
            builder: (context) => NewScreen(
              color: Colors.red,
              name: 'Red Screen',
            ),
          ),
        ],
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: FloatingActionButton.extended(
        //   backgroundColor: Colors.redAccent,
        //   heroTag: 'toggle_grid',
        //   label: Text('${_bottomNav ? 'Hide' : 'Show'} Bottom Bar'),
        //   icon: Icon(Icons.border_bottom),
        //   onPressed: () {
        //     if (mounted)
        //       setState(() {
        //         _bottomNav = !_bottomNav;
        //       });
        //   },
        // ),
      ),
    );
  }
}

class FancyTitle extends StatelessWidget {
  const FancyTitle({
    Key key,
    @required this.title,
    this.logo,
  }) : super(key: key);

  final Widget title;
  final Widget logo;

  @override
  Widget build(BuildContext context) {
    if (logo == null) {
      return logo;
    }
    return Row(
      children: <Widget>[
        logo,
        Container(width: 4.0),
        title,
      ],
    );
  }
}

class NewScreen extends StatelessWidget {
  const NewScreen({
    Key key,
    @required this.color,
    @required this.name,
  }) : super(key: key);

  final Color color;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: RaisedButton.icon(
          icon: Icon(Icons.arrow_right),
          label: Text("Push to Screen"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBar(),
                body: NewScreen(color: color, name: name),
              ),
            ));
          },
        ),
      ),
    );
  }
}
