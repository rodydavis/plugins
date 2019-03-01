import 'dart:io';

import 'package:dynamic_tabs/data/classes/tab.dart';
import 'package:dynamic_tabs/ui/common/grid_item.dart';
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
                  flex: 9,
                  child: _buildBody(context),
                ),
                Flexible(
                  flex: 1,
                  child: _buildBottomBar(context),
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
                flex: 9,
                child: _buildBody(context),
              ),
              Flexible(
                flex: 1,
                child: _buildBottomBar(context),
              ),
            ],
          ),
        ));
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      // color: Colors.amber,
      // padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[]
          ..addAll(_tabs
              .take(4)
              .map(
                (t) => DragTarget<String>(
                      builder: (context, possible, rejected) {
                        print(possible);
                        return GridTabItem(
                          tab: t,
                          active: _tabs.indexOf(t) <= 4,
                          adaptive: widget.adaptive,
                          // draggable: true,
                        );
                      },
                      onWillAccept: (data) {
                        return true;
                      },
                      onAccept: (data) {
                        setState(() {
                          var _item = _tabs.firstWhere((i) => i.tag == data);
                          _tabs.removeAt(_tabs.indexOf(_item));
                          _tabs.insert(_tabs.indexOf(t), _item);
                        });
                      },
                    ),
              )
              .toList())
          ..add(GridTabItem(
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
          )),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.height * .5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Drag the icons to\norganize tabs.",
              style:
                  Theme.of(context).textTheme.display1.copyWith(fontSize: 22.0),
              textAlign: TextAlign.center,
            ),
            Container(height: 25.0),
            SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              width: MediaQuery.of(context).size.height * .5,
              child: GridView.count(
                crossAxisCount: 4,
                // physics: NeverScrollableScrollPhysics(),
                children: _tabs
                    .map(
                      (t) => GridTabItem(
                            active: _tabs.indexOf(t) > 3,
                            tab: t,
                            adaptive: widget.adaptive,
                            draggable: true,
                          ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveTabs(BuildContext context) {
    Navigator.of(context).pop(_tabs);
  }
}
