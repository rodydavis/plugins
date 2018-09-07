library native_widgets;

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Native Button
class NativeButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color buttonColor;
  final EdgeInsetsGeometry paddingExternal;
  final EdgeInsetsGeometry paddingInternal;
  final double minWidthAndroid;
  final double minSizeiOS;
  final double heightAndroid;
  final Color splashColorAndroid;

  NativeButton(
      {this.child,
      this.onPressed,
      this.paddingExternal,
      this.paddingInternal,
      this.buttonColor,
      this.minWidthAndroid,
      this.splashColorAndroid,
      this.heightAndroid,
      this.minSizeiOS});

  @override
  Widget build(BuildContext context) {
    return (Padding(
      padding:
          paddingExternal == null ? const EdgeInsets.all(0.0) : paddingExternal,
      child: Platform.isIOS
          ? CupertinoButton(
              padding: paddingInternal,
              minSize: minSizeiOS,
              color: buttonColor,
              child: child,
              onPressed: Feedback.wrapForTap(onPressed, context),
            )
          : MaterialButton(
              minWidth: minWidthAndroid,
              height: heightAndroid,
              color: buttonColor,
              splashColor: splashColorAndroid,
              padding: paddingInternal,
              child: child,
              onPressed: Feedback.wrapForTap(onPressed, context),
            ),
    ));
  }
}

// Native Dialog Action for Native Dialog
class NativeDialogAction {
  final String text;
  final bool isDestructive;
  final VoidCallback onPressed;

  NativeDialogAction(
      {@required this.text, this.isDestructive, @required this.onPressed});
}

// Native Dialog
class NativeDialog extends StatefulWidget {
  final String title;
  final String content;
  final TextStyle textStyle;
  final List<NativeDialogAction> actions;

  NativeDialog(
      {@required this.actions,
      this.title,
      @required this.content,
      this.textStyle});

  @override
  _NativeDialogState createState() => _NativeDialogState();
}

class _NativeDialogState extends State<NativeDialog> {
  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS
        ? CupertinoAlertDialog(
            title: widget.title == null
                ? null
                : Text(
                    widget.title,
                    style: widget.textStyle,
                  ),
            content: Text(
              widget.content,
              style: widget.textStyle,
            ),
            actions: widget.actions
                .map((NativeDialogAction item) => CupertinoDialogAction(
                      child: Text(item.text),
                      isDestructiveAction: item.isDestructive,
                      onPressed: Feedback.wrapForTap(item.onPressed, context),
                    ))
                .toList())
        : AlertDialog(
            title: widget.title == null
                ? null
                : Text(
                    widget.title,
                    style: widget.textStyle,
                  ),
            content: Text(
              widget.content,
              style: widget.textStyle,
            ),
            actions: widget.actions
                .map((NativeDialogAction item) => FlatButton(
                      child: Text(
                        item.text,
                        style: TextStyle(
                            color:
                                item.isDestructive ? Colors.redAccent : null),
                      ),
                      onPressed: item.onPressed,
                    ))
                .toList()));
  }
}

// Native Loading Indicator

class NativeLoadingIndicator extends StatelessWidget {
  final Widget text;
  final bool center;

  NativeLoadingIndicator({Key key, this.text, this.center});

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS
        ? text == null
            ? center != null && center
                ? Center(
                    child: CupertinoActivityIndicator(
                      key: key,
                      animating: true,
                    ),
                  )
                : CupertinoActivityIndicator(
                    key: key,
                    animating: true,
                  )
            : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CupertinoActivityIndicator(
                      key: key,
                      animating: true,
                    ),
                    Container(
                      height: 10.0,
                    ),
                    text,
                  ],
                ),
              )
        : text == null
            ? center != null && center
                ? Center(
                    child: CircularProgressIndicator(key: key),
                  )
                : CircularProgressIndicator(key: key)
            : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      key: key,
                    ),
                    Container(
                      height: 10.0,
                    ),
                    text,
                  ],
                ),
              ));
  }
}

// Native Switch
class NativeSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;

  NativeSwitch(
      {Key key,
      @required this.value,
      @required this.onChanged,
      this.activeColor});

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS
        ? CupertinoSwitch(
            key: key,
            value: value,
            onChanged: onChanged,
            activeColor:
                activeColor == null ? CupertinoColors.activeGreen : activeColor,
          )
        : Switch(
            key: key,
            value: value,
            onChanged: onChanged,
            activeColor: activeColor,
          ));
  }
}

// Native Tab Bar
class NativeBottomTabBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final ValueChanged<int> onTap;
  final Color activeColor;
  final double iconSize;
  final int currentIndex;

  NativeBottomTabBar(
      {Key key,
      @required this.items,
      this.onTap,
      this.activeColor,
      this.currentIndex,
      this.iconSize});

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS
        ? CupertinoTabBar(
            key: key,
            items: items,
            onTap: onTap,
            currentIndex: currentIndex == null ? 0 : currentIndex,
            activeColor:
                activeColor == null ? CupertinoColors.activeBlue : activeColor,
            backgroundColor: Colors.transparent,
            iconSize: iconSize == null ? 30.0 : iconSize,
          )
        : BottomNavigationBar(
            key: key,
            type: BottomNavigationBarType.fixed,
            onTap: onTap,
            currentIndex: currentIndex == null ? 0 : currentIndex,
            fixedColor: activeColor,
            items: items,
            iconSize: iconSize == null ? 30.0 : iconSize,
          ));
  }
}

class NativePicker extends StatefulWidget {
  final Widget title;
  final Widget leading;
  final Widget trailing;
  final TextStyle style;
  final List<String> items;
  final ValueChanged<String> onSelection;
  final bool setFirstDefault;
  final String noneSelectedMessage;
  final String defaultItem;

  NativePicker({
    this.leading,
    this.title,
    this.trailing,
    this.style,
    this.defaultItem,
    @required this.items,
    @required this.onSelection,
    this.setFirstDefault,
    this.noneSelectedMessage,
  });

  @override
  _NativePickerState createState() => _NativePickerState();
}

class _NativePickerState extends State<NativePicker> {
  double _kPickerSheetHeight = 216.0;
  double _kPickerItemHeight = 32.0;
  int _index = 0;
  String _selection = "";

  @override
  void initState() {
    super.initState();
    if (widget.setFirstDefault != null && widget.setFirstDefault) {
      setState(() {
        _selection = widget.items[_index];
        itemSelected(_selection);
      });
    } else if (widget.defaultItem != null && widget.defaultItem.isNotEmpty)
      setState(() {
        _selection = widget.defaultItem;
        itemSelected(_selection);
      });
  }

  void itemSelected(String selection) => widget.onSelection;

  Widget _buildPicker() {
    final FixedExtentScrollController scrollController =
        new FixedExtentScrollController(initialItem: _index);

    return Platform.isIOS
        ? Container(
            height: _kPickerSheetHeight,
            color: CupertinoColors.white,
            child: new DefaultTextStyle(
              style: const TextStyle(
                color: CupertinoColors.black,
                fontSize: 22.0,
              ),
              child: new GestureDetector(
                // Blocks taps from propagating to the modal sheet and popping.
                onTap: () {},
                child: new SafeArea(
                  child: new CupertinoPicker(
                    scrollController: scrollController,
                    itemExtent: _kPickerItemHeight,
                    backgroundColor: CupertinoColors.white,
                    onSelectedItemChanged: (int index) {
                      setState(() {
                        _index = index;
                        _selection = widget.items[_index];
                        itemSelected(_selection);
                      });
                    },
                    children: new List<Widget>.generate(widget.items.length,
                        (int index) {
                      return new Center(
                        child: new Text(
                          widget.items[index],
                          textScaleFactor: 1.0,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          )
        : DropdownButton<String>(
            value: _selection,
            items: widget.items
                .map(
                  (String item) => DropdownMenuItem<String>(
                      value: item,
                      child: SizedBox(
                          width: 200.0,
                          child: Text(
                            item,
                            textScaleFactor: 1.0,
                            style: widget.style,
                          ))),
                )
                .toList(),
            onChanged: (String s) {
              setState(() {
                _selection = s;
                itemSelected(_selection);
              });
            });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.leading,
      title: widget.title,
      subtitle: widget.items == null
          ? null
          : Platform.isIOS
              ? Text(
                  _selection == null || _selection.isEmpty
                      ? widget.noneSelectedMessage
                      : _selection,
                  textScaleFactor: 1.0,
                  style: widget.style,
                )
              : _buildPicker(),
      trailing: widget.trailing,
      onTap: !Platform.isIOS
          ? null
          : () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return _buildPicker();
                },
              );
            },
    );
  }
}

// Native App Bar
class NativeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final Widget leading;
  final Widget title;
  final List<Widget> actions;

  // final TabBar bottom;

  NativeAppBar({
    Key key,
    this.foregroundColor,
    this.backgroundColor,
    this.leading,
    this.title,
    this.actions,
    this.preferredSize = const Size.fromHeight(56.0),
  });

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS
        ? CupertinoNavigationBar(
            middle: title,
            backgroundColor:
                backgroundColor == null ? Colors.transparent : backgroundColor,
            leading: leading,
            actionsForegroundColor: foregroundColor,
            trailing: actions == null
                ? null
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: actions.map((Widget item) => item).toList(),
                  ),
          )
        : AppBar(
            backgroundColor: backgroundColor,
            key: key,
            title: title,
            actions: actions,
            leading: leading,
          ));
  }
}
