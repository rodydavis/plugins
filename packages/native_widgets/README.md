# Native Widgets
[![pub package](https://img.shields.io/pub/v/native_widgets.svg)](https://pub.dartlang.org/packages/native_widgets)

A Flutter plugin to show the correct widgets for iOS and Android. 

Avoid duplicating code and just write once for supported widgets. 

Android will use Material Design and iOS will use Cupertino style widgets.

## Usage

To use this plugin, add `native_widgets` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

``` dart
// Import package
import 'package:native_widgets/native_widgets.dart';
```

### Button

``` dart
NativeButton(
    child: Text(
      'BUTTON TEXT HERE',
      textScaleFactor: 1.0,
    ),
    buttonColor: Colors.blue,
    padding: const EdgeInsets.all(10.0), // Add Padding (Optional)
    onPressed: () {
       // BUTTON PRESS ACTION HERE
    },
),
```

### Switch

``` dart
bool switchValue = false; // Set Inital Value
void handelChanged(bool value) {
 setState(() {
   switchValue = value; // Update the UI
 });
}
  
NativeSwitch(
    onChanged: handelChanged,
    value: switchValue,
),
```

### Dialog

``` dart
// Function to generate the dialog
void showNativeDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    );
}

// Show the Pop Up
void showNativePopUp(BuildContext context) {
showNativeDialog<null>(
  context: context,
  child: NativeDialog(
    title: "TITLE HERE",
    content:
        'DETAIL HERE',
    actions: <NativeDialogAction>[
      NativeDialogAction(
          text: 'BUTTON 1 TEXT',
          isDestructive: false, // Set True to indicate with red accent
          onPressed: () {
            Navigator.pop(context);
            // BUTTON 1 ACTION
          }),
      NativeDialogAction(
          text: 'BUTTON 2 TEXT',
          isDestructive: false,  // Set True to indicate with red accent
          onPressed: () {
            Navigator.pop(context);
            // BUTTON 2 ACTION
          }),
    ],
  ));
}
```

### Loading Indicator

``` dart
NativeLoadingIndicator();

NativeLoadingIndicator(text: Text('Loading...'));
```

### Tab Bar

``` dart
int _page = 0;
final _pageController = PageController();

void onPageChanged(int page) {
  setState(() {
    this._page = page;
  });
}

static const _kDuration = const Duration(milliseconds: 300);
static const _kCurve = Curves.ease;

void navigationTapped(int page) {
  _pageController.animateToPage(page, duration: _kDuration, curve: _kCurve);
}

@override
void dispose() {
  _pageController.dispose();
  super.dispose();
}

final List<Widget> _pages = <Widget>[
  ConstrainedBox(
    constraints: const BoxConstraints.expand(),
    child: Page1Widget(), // CHANGE TO YOUR PAGE
  ),
  ConstrainedBox(
    constraints: const BoxConstraints.expand(),
    child: Page2Widget(), // CHANGE TO YOUR PAGE
  ),
  ConstrainedBox(
    constraints: const BoxConstraints.expand(),
    child: Page3Widget(), // CHANGE TO YOUR PAGE
  ),
];

final Widget botNavBar = NativeBottomTabBar(
  currentIndex: _page,
  onTap: navigationTapped,
  activeColor: Colors.blueAccent,
  items: [
    BottomNavigationBarItem(
        icon: Icon(Icons.info),
        title: Text(
          "TAB 1",
          textScaleFactor: 1.0,
        )),
    BottomNavigationBarItem(
        icon: Icon(Icons.info),
        title: Text(
          "TAB 2",
          textScaleFactor: 1.0,
        )),
    BottomNavigationBarItem(
        icon: Icon(Icons.info),
        title: Text(
          "TAB 3",
          textScaleFactor: 1.0,
        )),
  ]);
```

### App Bar

``` dart
appBar: NativeAppBar(
  title: Text('Title Here'),
  backgroundColor:
      Platform.isIOS ? null : globals.isDark ? null : Colors.white,
  leading: IconButton(
    icon: Icon(
      Icons.settings,
      color: globals.isDark ? Colors.white : Colors.black,
    ),
    onPressed: () {
      Navigator.pushNamed(context, '/settings');
    },
  ),
  actions: <Widget>[
    IconButton(
      icon: Icon(Icons.delete_sweep,
          color: globals.isDark ? Colors.white : Colors.black),
      onPressed: null,
    ),
    IconButton(
      icon: Icon(Icons.share,
          color: globals.isDark ? Colors.white : Colors.black),
      onPressed: null,
    ),
  ],
),
```
