import 'dart:io';

import 'package:cupertino_controllers/cupertino_controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../data/classes/tab.dart';
import 'edit_screen.dart';

class MoreTab extends StatefulWidget {
  const MoreTab({
    this.adaptive = false,
    @required this.tabs,
    this.tabsChanged,
    @required this.maxTabs,
    @required this.primaryColor,
    @required this.accentColor,
    @required this.currentIndex,
    @required this.persitIndex,
    @required this.navigator,
    @required this.tag,
  });

  final bool adaptive;
  final List<DynamicTab> tabs;
  final ValueChanged<List<DynamicTab>> tabsChanged;
  final int maxTabs;
  final Color primaryColor;
  final Color accentColor;
  final bool persitIndex;
  final currentIndex;
  final NavigatorState navigator;
  final String tag;

  @override
  _MoreTabState createState() => _MoreTabState();
}

class _MoreTabState extends State<MoreTab> {
  LocalStorage _storage;

  @override
  void initState() {
    if (widget.persitIndex) {
      _storage = new LocalStorage((widget?.tag ?? "app_dynamic_tabs"));
      _storage.ready.then((value) {
        _loadIndex();
      });
    }
    super.initState();
  }

  void _loadIndex() {
    int _index = _storage.getItem(navKey);
    if (_index != null) {
      if (_index > widget.tabs.length) {
        _saveIndex(0);
      }
      final _extraItems =
          widget.tabs.getRange(widget.maxTabs, widget.tabs.length).toList();
      widget.navigator.push(MaterialPageRoute(
        builder: (context) => _extraItems[_index].child,
      ));
    }
  }

  void _saveIndex(int index) {
    print("Saving Index: $index...");
    if (widget.persitIndex) _storage.setItem(navKey, index);
  }

  String get navKey => "${(widget?.tag ?? "") + "_"}more_nav_index";

  @override
  Widget build(BuildContext context) {
    final _extraItems =
        widget.tabs.getRange(widget.maxTabs, widget.tabs.length).toList();
    if (widget.adaptive && Platform.isIOS) {
      return CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              backgroundColor: widget.primaryColor,
              actionsForegroundColor: widget.accentColor,
              largeTitle: Text("More"),
              trailing: CupertinoButton(
                child: Text("Edit"),
                padding: EdgeInsets.all(0.0),
                onPressed: () => _goToEditScreen(context),
              ),
            ),
            SliverPadding(
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
                          onTap: () async {
                            _saveIndex(index);
                            await widget.navigator.push(
                              CupertinoPageRoute(
                                builder: (context) => i.child,
                              ),
                            );
                          },
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
            padding: EdgeInsets.all(0.0),
            itemCount: _extraItems.length,
            itemBuilder: (BuildContext context, int index) {
              final i = _extraItems[index];
              return ListTile(
                leading: i.tab.icon,
                title: i.tab.title,
                trailing:
                    widget.adaptive ? Icon(Icons.keyboard_arrow_right) : null,
                onTap: () async {
                  _saveIndex(index);
                  await widget.navigator.push(
                    MaterialPageRoute(
                      builder: (context) => i.child,
                    ),
                  );
                },
              );
            },
          ),
        ));
  }

  void _goToEditScreen(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .push<List<DynamicTab>>(MaterialPageRoute(
      builder: (context) => EditScreen(
            maxTabs: widget.maxTabs,
            adaptive: widget.adaptive,
            tabs: widget.tabs,
          ),
      fullscreenDialog: true,
    ))
        .then((newTabs) {
      if (newTabs != null) widget.tabsChanged(newTabs);
    });
  }
}
