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
    this.child,
    this.routes,
    this.leadingColor,
    this.width = 600,
    this.fadeDuration = const Duration(milliseconds: 50),
    this.breakpoint = const Size(800, 800),
    this.showFullScreen = true,
    this.showDoneButton = true,
  }) : super();

  /// Title of pop up
  final String title;

  /// Builder is needed to get the context
  final Widget child;

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

  final bool showFullScreen;

  final showDoneButton;

  @override
  _MobilePopUpState createState() => _MobilePopUpState();
}

class _MobilePopUpState extends State<MobilePopUp> {
  Color leadingColor;
  bool fullscreen = false;

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
    final _full = _mobile || fullscreen;
    final _content = _PopUpContent(
      title: widget?.title,
      showDoneButton: widget.showDoneButton,
      child: widget?.child,
      routes: widget?.routes,
      leadingColor: leadingColor,
      fullscreen: !widget.showFullScreen ? null : fullscreen,
      toggleFullscreen: (value) {
        if (mounted)
          setState(() {
            fullscreen = value;
          });
      },
    );
    return AnimatedContainer(
      duration: widget.fadeDuration,
      padding: EdgeInsets.symmetric(
        vertical: _full ? 0 : _size.height / 5,
        horizontal: _full ? 0 : (_size.width - widget.width) / 2,
      ),
      child: Builder(
        builder: (_) {
          if (_full) return _content;
          return CupertinoPopupSurface(
            isSurfacePainted: true,
            child: _content,
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
    this.toggleFullscreen,
    this.fullscreen,
    this.routes,
    @required this.showDoneButton,
  }) : super(key: key);

  final String title;
  final Widget child;
  final Map<String, WidgetBuilder> routes;
  final Color leadingColor;
  final ValueChanged<bool> toggleFullscreen;
  final bool fullscreen;
  final bool showDoneButton;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes ?? const <String, WidgetBuilder>{},
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context),
      home: Scaffold(
        appBar: AppBar(
          leading: showDoneButton
              ? _ExitButton(
                  color: leadingColor,
                  navigator: Navigator.of(context),
                )
              : null,
          actions: <Widget>[
            if (fullscreen != null)
              IconButton(
                icon:
                    Icon(fullscreen ? Icons.fullscreen_exit : Icons.fullscreen),
                onPressed: () => toggleFullscreen(!fullscreen),
              )
          ],
          title: title == null ? null : Text(title),
        ),
        body: child,
      ),
    );
  }
}

class _ExitButton extends StatelessWidget {
  _ExitButton({
    this.color,
    @required this.navigator,
  });
  final Color color;
  final NavigatorState navigator;
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
          navigator.pop();
        },
      );
    }

    return IconButton(
      icon: Icon(Icons.close, color: color),
      tooltip: 'Back',
      padding: EdgeInsets.zero,
      onPressed: () {
        navigator.pop();
      },
    );
  }
}
