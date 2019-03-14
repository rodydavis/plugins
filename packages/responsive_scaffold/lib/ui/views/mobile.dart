import 'package:flutter/material.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';

class MobileView extends StatelessWidget {
  const MobileView({
    Key key,
    @required this.slivers,
    @required this.detailBuilder,
    @required this.children,
    @required this.itemBuilder,
    @required this.itemCount,
    @required this.noItems,
    @required this.nullItems,
  }) : super(key: key);

  final List<Widget> slivers;
  final DetailWidgetBuilder detailBuilder;
  final List<Widget> children;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final Widget noItems;
  final Widget nullItems;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[]
        ..addAll(slivers ?? [])
        ..add(SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(MaterialPageRoute(builder: (context) {
                    final _details = detailBuilder(context, index);
                    return new DetailView(
                        itemCount: itemCount,
                        nullItems: nullItems,
                        noItems: noItems,
                        details: _details);
                  }));
                },
                child: children == null
                    ? itemBuilder(context, index)
                    : children[index],
              );
            },
            childCount: itemCount,
          ),
        )),
    );
  }
}

class DetailView extends StatelessWidget {
  const DetailView({
    Key key,
    @required this.itemCount,
    @required this.nullItems,
    @required this.noItems,
    @required DetailsScreen details,
  })  : _details = details,
        super(key: key);

  final int itemCount;
  final Widget nullItems;
  final Widget noItems;
  final DetailsScreen _details;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _details?.appBar,
      body: itemCount == null
          ? nullItems ?? Center(child: CircularProgressIndicator())
          : itemCount == 0
              ? noItems ?? Center(child: Text("No Items Found"))
              : _details.body,
    );
  }
}
