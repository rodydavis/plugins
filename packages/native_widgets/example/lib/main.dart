import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:math' as math;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('en', 'US'),
        Locale('he', 'IL'),
      ],
      home: NativeAppLook(),
    );
  }
}

class NativeAppLook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print(MaterialLocalizations.of(context));
    final bool showMaterial = false;

    return NativeScaffold(
      hideAppBar: true,
      androidTopNavigation: false,
      showMaterial: showMaterial,
      title: Text("Native Appbar"),
      body: Container(),
      tabs: [
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          title: Text("Info"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text("About"),
        ),
      ],
      pages: <Widget>[
        Page1(),
        Page2(),
      ],
      leading: Icon(Icons.menu),
      actions: <Widget>[
        Icon(Icons.share),
      ],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.info),
        onPressed: () =>
            showAlertPopup(context, "Native Dialog", "Button Submitted!"),
      ),
    );
  }
}

void showAlertPopup(BuildContext context, String title, String detail) async {
  void showSimpleDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) => child,
    );
  }

  return showSimpleDialog<void>(
      context: context,
      child: NativeDialog(
        title: title,
        content: detail,
        actions: <NativeDialogAction>[
          NativeDialogAction(
              text: 'Delete',
              isDestructive: true,
              onPressed: () {
                Navigator.pop(context);
              }),
          NativeDialogAction(
              text: 'Ok',
              isDestructive: false,
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ));
}

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  bool _active = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NativeAppBar(
        title: const Text("Home"),
      ),
      body: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            ListTile(
              title: const Text("Loading Indicator..."),
              trailing: NativeLoadingIndicator(),
            ),
            ListTile(
              title: const Text("Switch"),
              trailing: NativeSwitch(
                value: _active,
                onChanged: (bool value) => setState(() => _active = value),
              ),
            ),
            NativeButton(
              child: const Text("Submit"),
              padding: const EdgeInsets.all(20.0),
              color: Colors.blue,
              onPressed: () =>
                  showAlertPopup(context, "Native Dialog", "Button Submitted!"),
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  @override
  Page2State createState() {
    return new Page2State();
  }
}

class Page2State extends State<Page2> {
  final List<Color> colorItems;
  final List<String> colorNameItems;
  bool _isSearching = false;

  Page2State()
      : colorItems = List<Color>.generate(_kChildCount, (int index) {
          return coolColors[math.Random().nextInt(coolColors.length)];
        }),
        colorNameItems = List<String>.generate(_kChildCount, (int index) {
          return coolColorNames[math.Random().nextInt(coolColorNames.length)];
        });

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: NativeSearchAppBar(
    //     title: const Text("Second Page"),
    //     isSearching: _isSearching,
    //     onSearchPressed: () {
    //       setState(() {
    //         _isSearching = !_isSearching;
    //       });
    //     },
    //     onChanged: (String value) {
    //       print(value);
    //     },
    //     // actions: <Widget>[
    //     //   NativeIconButton(
    //     //     icon: Icon(Icons.info_outline),
    //     //     iosIcon: Icon(CupertinoIcons.info),
    //     //   ),
    //     // ],
    //   ),
    // );
    return CupertinoPageScaffold(
      child: CustomScrollView(
        semanticChildCount: _kChildCount,
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text("Large Title"),
            trailing: Icon(Icons.info),
          ),
          SliverPadding(
            // Top media padding consumed by CupertinoSliverNavigationBar.
            // Left/Right media padding consumed by Tab1RowItem.
            padding: MediaQuery.of(context)
                .removePadding(
                  removeTop: true,
                  removeLeft: true,
                  removeRight: true,
                )
                .padding,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Tab1RowItem(
                    index: index,
                    lastItem: index == _kChildCount - 1,
                    color: colorItems[index],
                    colorName: colorNameItems[index],
                  );
                },
                childCount: _kChildCount,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const int _kChildCount = 50;

const List<Color> coolColors = <Color>[
  Color.fromARGB(255, 255, 59, 48),
  Color.fromARGB(255, 255, 149, 0),
  Color.fromARGB(255, 255, 204, 0),
  Color.fromARGB(255, 76, 217, 100),
  Color.fromARGB(255, 90, 200, 250),
  Color.fromARGB(255, 0, 122, 255),
  Color.fromARGB(255, 88, 86, 214),
  Color.fromARGB(255, 255, 45, 85),
];

const List<String> coolColorNames = <String>[
  'Sarcoline',
  'Coquelicot',
  'Smaragdine',
  'Mikado',
  'Glaucous',
  'Wenge',
  'Fulvous',
  'Xanadu',
  'Falu',
  'Eburnean',
  'Amaranth',
  'Australien',
  'Banan',
  'Falu',
  'Gingerline',
  'Incarnadine',
  'Labrador',
  'Nattier',
  'Pervenche',
  'Sinoper',
  'Verditer',
  'Watchet',
  'Zaffre',
];

class Tab1RowItem extends StatelessWidget {
  const Tab1RowItem({this.index, this.lastItem, this.color, this.colorName});

  final int index;
  final bool lastItem;
  final Color color;
  final String colorName;

  @override
  Widget build(BuildContext context) {
    final Widget row = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // Navigator.of(context).push(CupertinoPageRoute<void>(
        //   title: colorName,
        //   builder: (BuildContext context) => Tab1ItemPage(
        //     color: color,
        //     colorName: colorName,
        //     index: index,
        //   ),
        // ));
      },
      child: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, top: 8.0, bottom: 8.0, right: 8.0),
          child: Row(
            children: <Widget>[
              Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(colorName),
                      const Padding(padding: EdgeInsets.only(top: 8.0)),
                      const Text(
                        'Buy this cool color',
                        style: TextStyle(
                          color: Color(0xFF8E8E93),
                          fontSize: 13.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.plus_circled,
                  semanticLabel: 'Add',
                ),
                onPressed: () {},
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.share,
                  semanticLabel: 'Share',
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );

    if (lastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        Container(
          height: 1.0,
          color: const Color(0xFFD9D9D9),
        ),
      ],
    );
  }
}
