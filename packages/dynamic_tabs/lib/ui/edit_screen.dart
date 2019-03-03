import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/classes/tab.dart';
import 'common/grid_item.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({
    this.adaptive = false,
    @required this.tabs,
    @required this.maxTabs,
  });

  final bool adaptive;
  final List<DynamicTab> tabs;
  final int maxTabs;

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  List<DynamicTab> _tabs;
  @override
  void initState() {
    _tabs = widget.tabs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.adaptive && Platform.isIOS) {
      return DefaultTextStyle(
          style: CupertinoTheme.of(context).textTheme.textStyle,
          child: CupertinoPageScaffold(
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
                  flex: MediaQuery.of(context).size.height < 400 ? 5 : 9,
                  child: _buildBody(context),
                ),
                Flexible(
                  flex: 1,
                  child: BottomEditableTabBar(
                    adaptive: widget.adaptive,
                    maxTabs: widget.maxTabs,
                    tabs: _tabs,
                    onChanged: (List<DynamicTab> tabs) {
                      setState(() {
                        _tabs = tabs;
                      });
                    },
                  ),
                ),
              ],
            ),
          ));
    }
    return DefaultTextStyle(
        style: Theme.of(context).textTheme.display1,
        child: Scaffold(
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
                flex: MediaQuery.of(context).size.height < 400 ? 5 : 9,
                child: _buildBody(context),
              ),
              Flexible(
                flex: 1,
                child: BottomEditableTabBar(
                  adaptive: widget.adaptive,
                  maxTabs: widget.maxTabs,
                  tabs: _tabs,
                  onChanged: (List<DynamicTab> tabs) {
                    setState(() {
                      _tabs = tabs;
                    });
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 20.0),
              child: Text(
                "Drag the icons to\norganize tabs.",
                style: Theme.of(context)
                    .textTheme
                    .display1
                    .copyWith(fontSize: 22.0),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: (MediaQuery.of(context).orientation ==
                                  Orientation.landscape &&
                              MediaQuery.of(context).size.width > 600) ||
                          MediaQuery.of(context).size.width > 600
                      ? 6
                      : 4,
                  children: _tabs
                      .map(
                        (t) => GridTabItem(
                              active: _tabs.indexOf(t) >= widget.maxTabs,
                              tab: t,
                              adaptive: widget.adaptive,
                              draggable: true,
                            ),
                      )
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _saveTabs(BuildContext context) {
    Navigator.of(context).pop(_tabs);
  }
}

class BottomEditableTabBar extends StatefulWidget {
  const BottomEditableTabBar({
    @required this.maxTabs,
    @required this.tabs,
    @required this.adaptive,
    @required this.onChanged,
  });

  final bool adaptive;
  final int maxTabs;
  final List<DynamicTab> tabs;
  final ValueChanged<List<DynamicTab>> onChanged;

  @override
  _BottomEditableTabBarState createState() => _BottomEditableTabBarState();
}

class _BottomEditableTabBarState extends State<BottomEditableTabBar> {
  List<DynamicTab> _tabs;
  int _previewIndex;

  @override
  void initState() {
    _tabs = widget.tabs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [];
    List<DynamicTab> _targets = _tabs.take(widget.maxTabs).toList();
    for (var t in _targets) {
      _children.add(DragTarget<String>(
        builder: (context, possible, rejected) {
          print("Possible: $possible, Rejected: $rejected");
          return GridTabItem(
            tab: t,
            active: _previewIndex == null
                ? true
                : !(_targets.indexOf(t) == _previewIndex),
            adaptive: widget.adaptive,
            // draggable: true,
          );
        },
        onWillAccept: (String data) {
          setState(() {
            _previewIndex = _targets.indexOf(t);
          });
          return true;
        },
        onLeave: (String data) {
          setState(() {
            _previewIndex = null;
          });
        },
        onAccept: (String data) {
          final DynamicTab _baseTab = _targets[_previewIndex];
          final DynamicTab _newTab = _tabs.firstWhere((t) => t.tag == data);
          final int _oldIndex = _tabs.indexOf(_newTab);

          _tabs.removeAt(_previewIndex);
          _tabs.insert(_previewIndex, _newTab);
          _tabs.removeAt(_oldIndex);
          _tabs.insert(_oldIndex, _baseTab);

          widget.onChanged(_tabs);
          
          setState(() {
            _previewIndex = null;
          });
        },
      ));
    }

    _children.add(GridTabItem(
      tab: DynamicTab(
        child: Container(),
        tab: BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          title: Text("More"),
        ),
        tag: "",
      ),
      draggable: false,
      active: false,
      adaptive: widget.adaptive,
    ));
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _children,
      ),
    );
  }
}
