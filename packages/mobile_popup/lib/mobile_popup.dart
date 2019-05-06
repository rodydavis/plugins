import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

export 'pop_up.dart';

/// showDialog(
///   context: context,
///   builder: (context) => MobilePopUp(
///         title: 'App Settings',
///         builder: Builder(
///           builder: (navigator) => SettingsScreen(),
///         ),
///       ),
/// );
class MobilePopUp extends StatefulWidget {
  const MobilePopUp({
    this.title = 'Info',
    this.builder,
    this.routes,
    this.leadingColor,
    this.width = 600,
    this.fadeDuration = const Duration(milliseconds: 50),
    this.breakpoint = const Size(800, 800),
  }) : super();

  /// Title of pop up
  final String title;

  /// Builder is needed to get the context
  final Widget builder;

  /// Need to Pass in the routes of the app so that the nested navigation will work correctly
  final Map<String, WidgetBuilder> routes;

  /// Dynamic themes will need to pass the color of the close icon
  final Color leadingColor;

  /// Breakpoint in which it will show the popup and not a fullscreen dialog
  final Size breakpoint;

  /// Duration of the fade between a full screen dialog and pop up
  final Duration fadeDuration;

  /// Preferred width of popup
  final double width;

  @override
  _MobilePopUpState createState() => _MobilePopUpState();
}

class _MobilePopUpState extends State<MobilePopUp> {
  Color leadingColor;

  @override
  void didUpdateWidget(MobilePopUp oldWidget) {
    if (oldWidget.leadingColor != widget.leadingColor) {
      init();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    if (mounted)
      setState(() {
        leadingColor = widget?.leadingColor;
      });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _mobile = _size.width < widget.breakpoint.width ||
        _size.height < widget.breakpoint.height;

    return AnimatedContainer(
      duration: widget.fadeDuration,
      padding: _mobile
          ? null
          : EdgeInsets.symmetric(
              vertical: _size.height / 5,
              horizontal: (_size.width - widget.width) / 2,
            ),
      child: Builder(
        builder: (context) {
          if (_mobile) {
            return _PopUpContent(
              title: widget?.title,
              child: widget?.builder,
              routes: widget?.routes,
              leadingColor: leadingColor,
            );
          }

          return CupertinoPopupSurface(
            isSurfacePainted: true,
            child: _PopUpContent(
              title: widget?.title,
              child: widget?.builder,
              routes: widget?.routes,
              leadingColor: leadingColor,
            ),
          );
        },
      ),
    );
  }
}

class _PopUpContent extends StatelessWidget {
  const _PopUpContent({
    Key key,
    @required this.title,
    this.leadingColor,
    this.child,
    this.routes,
  }) : super(key: key);

  final String title;
  final Widget child;
  final Map<String, WidgetBuilder> routes;
  final Color leadingColor;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes ?? const <String, WidgetBuilder>{},
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context),
      home: Scaffold(
        appBar: AppBar(
          leading: _ExitButton(color: leadingColor),
          title: title == null ? null : Text(title),
        ),
        body: child,
      ),
    );
  }
}

class _ExitButton extends StatelessWidget {
  _ExitButton({this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS || Platform.isMacOS) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        child: Tooltip(
          message: 'Back',
          child: Text(
            'Done',
            style: TextStyle(color: color),
          ),
          excludeFromSemantics: true,
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
      );
    }

    return IconButton(
      icon: Icon(Icons.close, color: color),
      tooltip: 'Back',
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
  }
}
