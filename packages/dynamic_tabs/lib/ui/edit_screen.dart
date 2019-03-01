import 'dart:io';

import 'package:dynamic_tabs/data/classes/tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({
    this.adaptive = false,
    @required this.tabs,
  });

  final bool adaptive;
  final List<DynamicTab> tabs;

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.adaptive && Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          trailing: CupertinoButton(
            padding: EdgeInsets.all(0.0),
            child: Text("Save"),
            onPressed: () => _saveTabs(context),
          ),
        ),
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Flexible(
              flex: 9,
              child: _buildBody(context),
            ),
            Flexible(
              flex: 1,
              child: _buildBottomBar(context),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveTabs(context),
          ),
        ],
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Flexible(
            flex: 9,
            child: _buildBody(context),
          ),
          Flexible(
            flex: 1,
            child: _buildBottomBar(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }

  Widget _buildBody(BuildContext context) {
    if (widget.adaptive && Platform.isIOS) {
      return DefaultTextStyle(
          style: CupertinoTheme.of(context).textTheme.textStyle,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.height * .5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Drag the icons to\norganize tabs.",
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .copyWith(fontSize: 22.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .5,
                    width: MediaQuery.of(context).size.height * .5,
                    child: GridView.count(
                      crossAxisCount: 4,
                      children: widget.tabs
                          .map((t) => GridTabItem(
                                icon: t.tab.icon,
                                title: t.tab.title,
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ));
    }
    return Center(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Drag the icons to organize tabs."),
          ],
        ),
      ),
    );
  }

  void _saveTabs(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class GridTabItem extends StatelessWidget {
  const GridTabItem({
    Key key,
    @required this.title,
    @required this.icon,
  }) : super(key: key);

  final Icon icon;
  final Text title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        icon,
        title,
      ],
    );
  }
}
