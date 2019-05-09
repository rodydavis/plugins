import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile_sidebar/utils/index.dart';

import 'common/index.dart';

class MobileSidebar extends StatefulWidget {
  MobileSidebar({
    @required this.items,
    this.showList = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.breakPoint = 800,
  });
  final List<MenuItem> items;
  final bool showList;
  final FloatingActionButton floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final double breakPoint;

  @override
  _MobileSidebarState createState() => _MobileSidebarState();
}

class _MobileSidebarState extends State<MobileSidebar> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < widget.breakPoint) {
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
                ActionButton(
                  color: item.color,
                  iconData: item.icon,
                  title: item.title,
                  subtitle: item.subtitle,
                  onTap: () {
                    item.push(context);
                  },
                ),
              ],
            ];
            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Padding(
                padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: getCrossAxisCount(context),
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  itemCount: _children.length,
                  itemBuilder: (context, index) {
                    return RaisedCard(_children[index]);
                  },
                  staggeredTileBuilder: (index) {
                    final i = _children[index];
                    return StaggeredTile.extent(1, 180.0);
                  },
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
                            onTap: () {
                              if (mounted)
                                setState(() {
                                  _index = widget.items.indexOf(item);
                                });
                            },
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

class MenuItem {
  const MenuItem({
    @required this.icon,
    @required this.subtitle,
    @required this.title,
    @required this.child,
    @required this.color,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;
  final Color color;

  void push(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => _MobileView(item: this),
        ),
      );
}

class _MobileView extends StatelessWidget {
  const _MobileView({
    Key key,
    @required this.item,
  }) : super(key: key);

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: item.child,
    );
  }
}
