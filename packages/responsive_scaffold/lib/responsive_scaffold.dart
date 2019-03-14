import 'package:flutter/material.dart';

class ResponsiveScaffold extends StatelessWidget {
  ResponsiveScaffold({
    this.tabletBreakpoint = const Size(480.0, 480.0),
    @required this.detailBuilder,
    this.appBar,
    this.drawer,
    this.endDrawer,
    this.slivers,
    @required List<Widget> children,
  }) : _childDelagate = SliverChildListDelegate(
          children,
        );

  ResponsiveScaffold.builder({
    this.tabletBreakpoint = const Size(480.0, 480.0),
    @required this.detailBuilder,
    this.appBar,
    this.drawer,
    this.slivers,
    this.endDrawer,
    @required IndexedWidgetBuilder itemBuilder,
    @required int itemCount,
  }) : _childDelagate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
        );

  final Size tabletBreakpoint;

  final DetailWidgetBuilder detailBuilder;

  final Widget appBar;

  final Widget drawer, endDrawer;

  final List<Widget> slivers;

  final SliverChildDelegate _childDelagate;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    if (_size.width >= tabletBreakpoint.width &&
        _size.height >= tabletBreakpoint.height) {
      // Tablet
      return Container();
    }

    // Mobile
    return Scaffold(
      drawer: drawer,
      endDrawer: endDrawer,
      appBar: appBar,
      body: CustomScrollView(
        slivers: <Widget>[]
          ..addAll(slivers ?? [])
          ..add(SliverList(
            delegate: _childDelagate,
            // delegate: SliverChildBuilderDelegate(
            //   (BuildContext context, int index) {
            //     return _childDelagate.build(context, index);
            //     //   return GestureDetector(
            //     //     onTap: () {
            //     //       Navigator.of(context, rootNavigator: true)
            //     //           .push(MaterialPageRoute(builder: (context) {
            //     //         final _details = detailBuilder(context, index);
            //     //         return Scaffold(
            //     //           body: CustomScrollView(
            //     //             slivers: <Widget>[
            //     //               SliverAppBar(
            //     //                 floating: true,
            //     //                 title: _details?.title,
            //     //                 actions: _details?.actions,
            //     //               ),
            //     //               SliverToBoxAdapter(
            //     //                 child: _details.body,
            //     //               ),
            //     //             ],
            //     //           ),
            //     //         );
            //     //       }));
            //     //     },
            //     //     child: _childDelagate.build(context, index),
            //     //   );
            //   },
            // ),
          )),
      ),
    );
  }
}

typedef DetailWidgetBuilder = DetailsScreen Function(
    BuildContext context, int index);

class DetailsScreen {
  const DetailsScreen({
    this.actions,
    @required this.body,
    this.title,
  });

  final List<Widget> actions;

  final Widget body;

  final Widget title;
}
