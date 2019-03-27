import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_controllers/cupertino_controllers.dart';

import '../data/classes/tab.dart';
import 'edit_screen.dart';

class MoreTab extends StatelessWidget {
  const MoreTab({
    this.adaptive = false,
    @required this.tabs,
    this.tabsChanged,
    @required this.maxTabs,
    @required this.primaryColor,
    @required this.accentColor,
  });

  final bool adaptive;
  final List<DynamicTab> tabs;
  final ValueChanged<List<DynamicTab>> tabsChanged;
  final int maxTabs;
  final Color primaryColor;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final _extraItems = tabs.getRange(maxTabs, tabs.length).toList();
    if (adaptive && Platform.isIOS) {
      return CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
        CupertinoSliverNavigationBar(
                  backgroundColor: primaryColor,
                  actionsForegroundColor: accentColor,
                  largeTitle: Text("More"),
                  trailing: CupertinoButton(
                    child: Text("Edit"),
                    padding: EdgeInsets.all(0.0),
                    onPressed: () => _goToEditScreen(context),
                  ),
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
                    final i = _extraItems[index];
                    final Icon _icon = i.tab.icon;
                    final Text _text = i.tab.title;
                    return DefaultTextStyle(
                        style: CupertinoTheme.of(context).textTheme.textStyle,
                        child: CupertinoListTile(
                          leading: _icon.icon,
                          title: _text,
                          lastItem: false,
                          ios: CupertinoListTileData(
                            style: CupertinoCellStyle.subtitle,
                            accessory: CupertinoAccessory.disclosureIndicator,
                          ),
                          onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => i.child,
                                ),
                              ),
                        ));
                  },
                  childCount: _extraItems.length,
                ),
              ),
            ),
          ],
        ),
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
        body: SafeArea(
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
                        builder: (context) => i.child,
                      ),
                    ),
              );
            },
          ),
        ));
  }

  void _goToEditScreen(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .push<List<DynamicTab>>(MaterialPageRoute(
      builder: (context) => EditScreen(
            maxTabs: maxTabs,
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
