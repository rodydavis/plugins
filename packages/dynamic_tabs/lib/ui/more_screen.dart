import 'dart:io';

import 'package:dynamic_tabs/ui/edit_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/classes/tab.dart';

class MoreTab extends StatelessWidget {
  const MoreTab({
    this.adaptive = false,
    @required this.tabs,
    this.tabsChanged,
  });

  final bool adaptive;
  final List<DynamicTab> tabs;
  final ValueChanged<List<DynamicTab>> tabsChanged;

  @override
  Widget build(BuildContext context) {
    if (adaptive && Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("More"),
          trailing: CupertinoButton(
            child: Text("Edit"),
            padding: EdgeInsets.all(0.0),
            onPressed: () => _goToEditScreen(context),
          ),
        ),
        child: _buildBody(context),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("More"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _goToEditScreen(context),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final _extraItems = tabs.getRange(4, tabs.length).toList();
    return SafeArea(
      child: ListView.builder(
        // separatorBuilder: (BuildContext context, int index) => Divider(),
        padding: EdgeInsets.all(0.0),
        itemCount: _extraItems.length,
        itemBuilder: (BuildContext context, int index) {
          final i = _extraItems[index];
          return ListTile(
            leading: i.tab.icon,
            title: i.tab.title,
            trailing: adaptive ? Icon(Icons.keyboard_arrow_right) : null,
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => adaptive && Platform.isIOS
                        ? CupertinoPageScaffold(
                            navigationBar: CupertinoNavigationBar(
                              middle: i?.title ?? i.tab.title,
                              previousPageTitle: "More",
                              trailing: i?.trailingAction,
                            ),
                            child: i.child,
                          )
                        : Scaffold(
                            appBar: AppBar(
                              title: i?.title ?? i.tab.title,
                              actions: <Widget>[
                                i?.trailingAction ?? Container()
                              ],
                            ),
                            body: i.child,
                          ),
                  ),
                ),
          );
        },
      ),
    );
  }

  void _goToEditScreen(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .push<List<DynamicTab>>(MaterialPageRoute(
      builder: (context) => EditScreen(
            adaptive: adaptive,
            tabs: tabs,
          ),
      fullscreenDialog: true,
    ))
        .then((newTabs) {
      if (newTabs != null) tabsChanged(newTabs);
    });
  }
}
