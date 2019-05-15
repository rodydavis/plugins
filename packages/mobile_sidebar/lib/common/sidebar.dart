import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../common/index.dart';
import '../utils/index.dart';

class MobileSidebar extends StatefulWidget {
  MobileSidebar({
    @required this.items,
    this.showList = true,
    this.floatingActionButton,
    this.persistIndex = false,
    this.floatingActionButtonLocation,
    this.breakPoint = 800,
    this.mobileBottomNavigation = false,
    this.tag = 'index',
  });
  final List<MenuItem> items;
  final bool showList;
  final FloatingActionButton floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final double breakPoint;
  final bool persistIndex;
  final bool mobileBottomNavigation;
  final String tag;

  @override
  _MobileSidebarState createState() => _MobileSidebarState();
}

class _MobileSidebarState extends State<MobileSidebar> {
  final LocalStorage _storage = LocalStorage('mobile_side_bar_settings');
  int _index = 0;
  String get key => '${widget?.tag ?? 'index'}';

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    if (widget.persistIndex) {
      await _storage.ready;

      final int _data = _storage.getItem(key);
      if (_data != null && _data != _index && _data <= widget.items.length) {
        _changeIndex(_data);
      }
    }
  }

  void _updateIndex(int value) async {
    _changeIndex(value);
    if (widget.persistIndex) {
      await _storage.setItem(key, value);
    }
  }

  void _changeIndex(int value) {
    if (mounted)
      setState(() {
        _index = value;
      });
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < widget.breakPoint) {
      if (widget.mobileBottomNavigation) {
        return Scaffold(
          floatingActionButton: widget?.floatingActionButton,
          floatingActionButtonLocation: widget?.floatingActionButtonLocation,
          body: Stack(
            children: <Widget>[
              for (var item in widget.items) ...[
                Offstage(
                  offstage: widget.items.indexOf(item) != _index,
                  child: item.child,
                ),
              ],
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _index,
            onTap: _updateIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              for (var item in widget.items) ...[
                BottomNavigationBarItem(
                  icon: Icon(item.icon),
                  title: Text(item.title),
                )
              ],
            ],
          ),
        );
      }
      return Scaffold(
        floatingActionButton: widget?.floatingActionButton,
        floatingActionButtonLocation: widget?.floatingActionButtonLocation,
        body: Builder(
          builder: (context) {
            if (widget.showList) {
              return ListView(
                children: <Widget>[
                  for (var item in widget.items) ...[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: item.color,
                        child: Icon(item.icon, color: Colors.white),
                      ),
                      title: Text(item.title),
                      subtitle: Text(item.subtitle),
                      onTap: () {
                        item.push(context);
                      },
                    ),
                  ],
                ],
              );
            }
            final _children = <Widget>[
              for (var item in widget.items) ...[
                RaisedChild(Container(
                  padding: EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () => item.push(context),
                    child: new GridActionItem(item: item),
                  ),
                )),
              ],
            ];
            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Padding(
                padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
                child: GridView.count(
                  crossAxisCount: getCrossAxisCount(context, itemWidth: 180),
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  children: _children,
                ),
              ),
            );
          },
        ),
      );
    }

    return CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      slivers: <Widget>[
        // SliverTopAppBar(title: _title),
        MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: SliverFillRemaining(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 250,
                    padding: EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        if (widget?.floatingActionButton != null) ...[
                          Container(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: widget.floatingActionButton,
                          ),
                        ],
                        for (var item in widget.items) ...[
                          ListTile(
                            selected: widget.items.indexOf(item) == _index,
                            leading: Icon(item.icon),
                            title: Text(item.title),
                            subtitle: Text(item.subtitle),
                            onLongPress: () {
                              item.push(context);
                            },
                            onTap: () =>
                                _updateIndex(widget.items.indexOf(item)),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Expanded(
                    child: widget.items[_index].child,
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
