library flutter_whatsnew;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class WhatsNewPage extends StatelessWidget {
  final Widget title;

  /// not recommended for iOS. Consider to open in fullscreenDialog.
  final Widget buttonText;
  final List<ListTile> items;
  final VoidCallback onButtonPressed;
  final bool changelog;
  final String changes;
  final Color backgroundColor;
  final Color buttonColor;

  const WhatsNewPage({
    @required this.items,
    @required this.title,
    @required this.buttonText,
    this.onButtonPressed,
    this.backgroundColor,
    this.buttonColor,
  })  : changelog = false,
        changes = null;

  const WhatsNewPage.changelog({
    @required this.title,
    @required this.buttonText,
    this.onButtonPressed,
    this.changes,
    this.backgroundColor,
    this.buttonColor,
  })  : changelog = true,
        items = null;

  static void showDetailPopUp(BuildContext context, String title, String detail) async {
    void showDemoDialog<T>({BuildContext context, Widget child}) {
      showDialog<T>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => child,
      );
    }

    return showDemoDialog<Null>(
      context: context,
      child: NativeDialog(
        title: Text(title),
        content: Text(detail),
        actions: <NativeDialogAction>[
          NativeDialogAction(
            text: Text('OK'),
            isDestructive: false,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Changelog: $changelog");
    if (Platform.isIOS) {
      return _buildIOS(context);
    }

    return _buildAndroid(context);
  }

  Widget _buildAndroid(BuildContext context) {
    if (changelog) {
      return Scaffold(
        backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Positioned(
                top: 10.0,
                left: 0.0,
                right: 0.0,
                child: title,
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 50.0,
                bottom: 80.0,
                child: ChangeLogView(
                  changes: changes,
                ),
              ),
              Positioned(
                bottom: 5.0,
                right: 10.0,
                left: 10.0,
                child: ListTile(
                  title: NativeButton(
                    child: buttonText,
                    color: buttonColor ?? Colors.blue,
                    onPressed: onButtonPressed ??
                        () {
                          Navigator.pop(context);
                        },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Positioned(
              top: 10.0,
              left: 0.0,
              right: 0.0,
              child: title,
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              top: 50.0,
              bottom: 80.0,
              child: ListView(
                children: items
                    .map(
                      (ListTile item) => ListTile(
                            title: item.title,
                            subtitle: item.subtitle,
                            leading: item.leading,
                            trailing: item.trailing,
                            onTap: item.onTap,
                            onLongPress: item.onLongPress,
                          ),
                    )
                    .toList(),
              ),
            ),
            Positioned(
              bottom: 5.0,
              right: 10.0,
              left: 10.0,
              child: ListTile(
                title: NativeButton(
                  child: buttonText,
                  color: buttonColor ?? Colors.blue,
                  onPressed: onButtonPressed ??
                      () {
                        Navigator.pop(context);
                      },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIOS(BuildContext context) {
    Widget child;
    if (changelog) {
      child = ChangeLogView(
        changes: changes,
      );
    } else {
      child = Material(
        child: ListView(
          children: items,
        ),
      );
    }
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: title,
        automaticallyImplyMiddle: false,
        trailing: CupertinoButton(
          child: buttonText,
          onPressed: onButtonPressed ??
              () {
                Navigator.pop(context);
              },
        ),
      ),
      child: SafeArea(
        child: child,
      ),
    );
  }
}

class ChangeLogView extends StatefulWidget {
  const ChangeLogView({this.changes});
  final String changes;
  @override
  _ChangeLogViewState createState() => _ChangeLogViewState();
}

class _ChangeLogViewState extends State<ChangeLogView> {
  String _changelog;

  @override
  void initState() {
    if (widget?.changes == null) {
      rootBundle.loadString("CHANGELOG.md").then((data) {
        setState(() {
          _changelog = data;
        });
      });
    } else {
      setState(() {
        _changelog = widget.changes;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_changelog == null) {
      return NativeLoadingIndicator(
        text: Text("Loading Changes..."),
      );
    }
    return Markdown(data: _changelog);
  }
}
