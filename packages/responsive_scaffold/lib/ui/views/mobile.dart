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
    @required this.detailScaffoldKey,
    @required this.useRootNavigator,
    @required this.navigator,
  }) : super(key: key);

  final List<Widget> slivers;
  final DetailWidgetBuilder detailBuilder;
  final List<Widget> children;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final Key detailScaffoldKey;
  final bool useRootNavigator;
  final NavigatorState navigator;

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
                  (navigator ?? Navigator.of(context))
                      .push(MaterialPageRoute(builder: (context) {
                    final _details = detailBuilder(context, index, false);
                    return new DetailView(
                        detailScaffoldKey: detailScaffoldKey,
                        itemCount: itemCount,
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
    @required this.detailScaffoldKey,
  })  : _details = details,
        super(key: key);

  final int itemCount;
  final Widget nullItems;
  final Widget noItems;
  final DetailsScreen _details;
  final Key detailScaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: detailScaffoldKey,
      appBar: _details?.appBar,
      body: _details.body,
    );
  }
}
