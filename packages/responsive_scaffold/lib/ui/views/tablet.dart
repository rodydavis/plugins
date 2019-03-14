import 'package:flutter/material.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';

class TabletView extends StatefulWidget {
  const TabletView({
    Key key,
    @required this.slivers,
    @required this.detailBuilder,
    @required this.children,
    @required this.itemBuilder,
    @required this.itemCount,
    @required this.noItems,
    @required this.nullItems,
    @required this.itemNotSelected,
    @required this.sideMenu,
  }) : super(key: key);

  final List<Widget> slivers;
  final DetailWidgetBuilder detailBuilder;
  final List<Widget> children;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final Widget noItems;
  final Widget nullItems;
  final Widget itemNotSelected;
  final Flexible sideMenu;

  @override
  _TabletViewState createState() => _TabletViewState();
}

class _TabletViewState extends State<TabletView> {
  DetailsScreen _details;
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        widget?.sideMenu ?? Container(),
        Flexible(
          flex: 3,
          child: widget?.itemCount == null
              ? widget?.nullItems ?? Center(child: CircularProgressIndicator())
              : widget.itemCount == 0
                  ? widget?.noItems ?? Center(child: Text("No Items Found"))
                  : CustomScrollView(
                      slivers: <Widget>[]
                        ..addAll(widget.slivers ?? [])
                        ..add(SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _details =
                                        widget.detailBuilder(context, index);
                                  });
                                },
                                child: widget.children == null
                                    ? widget.itemBuilder(context, index)
                                    : widget.children[index],
                              );
                            },
                            childCount: widget.itemCount,
                          ),
                        )),
                    ),
        ),
        Flexible(
          flex: 8,
          child: new DetailView(
            details: _details,
            itemNotSelected: widget?.itemNotSelected,
          ),
        ),
      ],
    );
  }
}

class DetailView extends StatelessWidget {
  const DetailView({
    Key key,
    @required DetailsScreen details,
    @required this.itemNotSelected,
  })  : _details = details,
        super(key: key);

  final DetailsScreen _details;
  final Widget itemNotSelected;

  @override
  Widget build(BuildContext context) {
    if (_details == null) {
      return itemNotSelected ??
          Center(
            child: Text("No Item Selected"),
          );
    }
    return Scaffold(
      appBar: _details?.appBar,
      body: _details?.body,
    );
  }
}
