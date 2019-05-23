import 'package:flutter/material.dart';

import '../../../responsive_scaffold.dart';
import '../list.dart';

class MobileView extends StatelessWidget {
  MobileView({
    Key key,
    @required this.slivers,
    @required this.detailBuilder,
    @required List<Widget> children,
    @required this.detailScaffoldKey,
    @required this.useRootNavigator,
    @required this.navigator,
    @required this.nullItems,
    @required this.emptyItems,
  })  : childDelagate = SliverChildListDelegate(
          children,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          addSemanticIndexes: false,
        ),
        super(key: key);

  MobileView.builder({
    Key key,
    @required this.slivers,
    @required this.detailBuilder,
    @required int itemCount,
    @required IndexedWidgetBuilder itemBuilder,
    @required this.detailScaffoldKey,
    @required this.useRootNavigator,
    @required this.navigator,
    @required this.nullItems,
    @required this.emptyItems,
  })  : childDelagate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          addSemanticIndexes: false,
        ),
        super(key: key);

  MobileView.custom({
    Key key,
    @required this.slivers,
    @required this.detailBuilder,
    @required this.childDelagate,
    @required this.detailScaffoldKey,
    @required this.useRootNavigator,
    @required this.navigator,
    @required this.nullItems,
    @required this.emptyItems,
  }) : super(key: key);

  final List<Widget> slivers;
  final DetailWidgetBuilder detailBuilder;
  final Key detailScaffoldKey;
  final bool useRootNavigator;
  final NavigatorState navigator;
  final Widget nullItems, emptyItems;
  final SliverChildDelegate childDelagate;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[]
        ..addAll(slivers ?? [])
        ..add(Builder(
          builder: (BuildContext context) {
            if (childDelagate?.estimatedChildCount == null && nullItems != null)
              return SliverFillRemaining(child: nullItems);
            if (childDelagate?.estimatedChildCount != null &&
                childDelagate.estimatedChildCount == 0 &&
                emptyItems != null)
              return SliverFillRemaining(child: emptyItems);
            return SliverList(
                delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return new KeepAlive(
                  keepAlive: true,
                  child: new IndexedSemantics(
                    index: index,
                    child: GestureDetector(
                      onTap: () {
                        (navigator ?? Navigator.of(context))
                            .push(MaterialPageRoute(builder: (context) {
                          final _details = detailBuilder(context, index, false);
                          return new DetailView(
                              detailScaffoldKey: detailScaffoldKey,
                              itemCount: childDelagate.estimatedChildCount,
                              details: _details);
                        }));
                      },
                      child: new Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: childDelagate.build(context, index),
                      ),
                    ),
                  ),
                );
              },
              childCount: childDelagate?.estimatedChildCount ?? 0,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              addSemanticIndexes: false,
            ));
          },
        )),
    );
  }
}

class DetailView extends StatelessWidget {
  const DetailView({
    Key key,
    @required this.itemCount,
    @required DetailsScreen details,
    @required this.detailScaffoldKey,
  })  : _details = details,
        super(key: key);

  final int itemCount;
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
