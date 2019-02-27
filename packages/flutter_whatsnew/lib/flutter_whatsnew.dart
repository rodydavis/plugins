library flutter_whatsnew;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_version/get_version.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WhatsNewPage extends StatefulWidget {
  final Widget title;
  final Widget buttonText;
  final List<ListTile> items;
  final bool showNow;
  final bool showOnVersionChange;
  final Widget home;
  final VoidCallback onButtonPressed;

  WhatsNewPage(
      {@required this.items,
      @required this.title,
      @required this.buttonText,
      @required this.home,
      this.onButtonPressed,
      this.showNow,
      this.showOnVersionChange});

  static void showDetailPopUp(
      BuildContext context, String title, String detail) async {
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
                }),
          ],
        ));
  }

  @override
  _WhatsNewPageState createState() => _WhatsNewPageState();
}

class _WhatsNewPageState extends State<WhatsNewPage> {
  @override
  void initState() {
    super.initState();
    isLoading = true;
    if (widget.showNow != null && widget.showNow) {
      setState(() {
        showHomePage = false;
        isLoading = false;
      });
    } else {
      if (widget.showOnVersionChange != null && widget.showOnVersionChange)
        _showOnVersionChange(context);
    }
  }

  Future<void> _showOnVersionChange(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String _lastVersion = prefs.getString('lastVersion');
    _lastVersion == null ? _lastVersion = "" : _lastVersion = _lastVersion;
    final String _projectVersion = await GetVersion.projectVersion;

    if (!_lastVersion.contains(_projectVersion)) {
      prefs.setString('lastVersion', _projectVersion);
      showHomePage = false;
    } else {
      showHomePage = true;
    }
    setState(() {
      isLoading = false;
    });
  }

  bool showHomePage = false;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return showHomePage
        ? widget.home
        : isLoading
            ? Scaffold(
                body: NativeLoadingIndicator(),
              )
            : (Scaffold(
                body: SafeArea(
                child: Stack(
                  fit: StackFit.loose,
                  children: <Widget>[
                    Positioned(
                      top: 10.0,
                      left: 0.0,
                      right: 0.0,
                      child: widget.title,
                    ),
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      top: 50.0,
                      bottom: 80.0,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ListBody(
                            children: widget.items
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
                                .toList()),
                      ),
                    ),
                    Positioned(
                        bottom: 5.0,
                        right: 10.0,
                        left: 10.0,
                        child: ListTile(
                          title: NativeButton(
                            child: widget.buttonText,
                            color: Colors.blue,
                            onPressed: widget.onButtonPressed != null
                                ? widget.onButtonPressed
                                : () {
                                    Navigator.push<dynamic>(
                                        context,
                                        MaterialPageRoute<dynamic>(
                                          builder: (BuildContext context) =>
                                              widget.home,
                                        ));
                                  },
                          ),
                        )),
                  ],
                ),
              )));
  }
}
