import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../responsive_scaffold.dart';
import '../responsive_list.dart';

class TabletView extends StatefulWidget {
  TabletView({
    Key key,
    @required this.slivers,
    @required this.detailBuilder,
    @required List<Widget> children,
    @required this.itemNotSelected,
    @required this.sideMenu,
    this.flexListView = 4,
    this.flexDetailView = 8,
    @required this.appBar,
    @required this.backgroundColor,
    @required this.bottomNavigationBar,
    @required this.bottomSheet,
    @required this.drawer,
    @required this.drawerDragStartBehavior,
    @required this.endDrawer,
    @required this.floatingActionButton,
    @required this.floatingActionButtonAnimator,
    @required this.floatingActionButtonLocation,
    @required this.persistentFooterButtons,
    @required this.primary,
    @required this.resizeToAvoidBottomInset,
    @required this.resizeToAvoidBottomPadding,
    @required this.scaffoldkey,
    @required this.detailScaffoldKey,
    @required this.nullItems,
    @required this.emptyItems,
  })  : childDelagate = SliverChildListDelegate(
          children,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          addSemanticIndexes: false,
        ),
        super(key: key);

  TabletView.builder({
    Key key,
    @required this.slivers,
    @required this.detailBuilder,
    @required int itemCount,
    @required IndexedWidgetBuilder itemBuilder,
    @required this.itemNotSelected,
    @required this.sideMenu,
    this.flexListView = 4,
    this.flexDetailView = 8,
    @required this.appBar,
    @required this.backgroundColor,
    @required this.bottomNavigationBar,
    @required this.bottomSheet,
    @required this.drawer,
    @required this.drawerDragStartBehavior,
    @required this.endDrawer,
    @required this.floatingActionButton,
    @required this.floatingActionButtonAnimator,
    @required this.floatingActionButtonLocation,
    @required this.persistentFooterButtons,
    @required this.primary,
    @required this.resizeToAvoidBottomInset,
    @required this.resizeToAvoidBottomPadding,
    @required this.scaffoldkey,
    @required this.detailScaffoldKey,
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

  TabletView.custom({
    Key key,
    @required this.slivers,
    @required this.detailBuilder,
    @required this.childDelagate,
    @required this.itemNotSelected,
    @required this.sideMenu,
    this.flexListView = 4,
    this.flexDetailView = 8,
    @required this.appBar,
    @required this.backgroundColor,
    @required this.bottomNavigationBar,
    @required this.bottomSheet,
    @required this.drawer,
    @required this.drawerDragStartBehavior,
    @required this.endDrawer,
    @required this.floatingActionButton,
    @required this.floatingActionButtonAnimator,
    @required this.floatingActionButtonLocation,
    @required this.persistentFooterButtons,
    @required this.primary,
    @required this.resizeToAvoidBottomInset,
    @required this.resizeToAvoidBottomPadding,
    @required this.scaffoldkey,
    @required this.detailScaffoldKey,
    @required this.nullItems,
    @required this.emptyItems,
  }) : super(key: key);

  final List<Widget> slivers;
  final DetailWidgetBuilder detailBuilder;
  final Widget itemNotSelected;
  final Flexible sideMenu;
  final int flexListView;
  final int flexDetailView;
  final Widget nullItems, emptyItems;

  final Widget floatingActionButton;

  final FloatingActionButtonLocation floatingActionButtonLocation;

  final Widget bottomNavigationBar;

  final Widget bottomSheet;

  final List<Widget> persistentFooterButtons;

  final FloatingActionButtonAnimator floatingActionButtonAnimator;

  final bool resizeToAvoidBottomPadding;

  final bool resizeToAvoidBottomInset;

  final bool primary;

  final Key scaffoldkey, detailScaffoldKey;

  // final bool extendBody;

  final DragStartBehavior drawerDragStartBehavior;

  final Color backgroundColor;

  final PreferredSizeWidget appBar;

  final Widget drawer, endDrawer;

  final SliverChildDelegate childDelagate;

  @override
  _TabletViewState createState() => _TabletViewState();
}

class _TabletViewState extends State<TabletView> {
  int _index;

  void reset() {
    setState(() {
      _index = null;
    });
  }

  // void update(DetailsScreen value) {
  //   setState(() {
  //     _index = value;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          widget?.sideMenu ?? Container(),
          Flexible(
            flex: widget.flexListView,
            child: Scaffold(
              key: widget?.scaffoldkey,
              floatingActionButton: widget?.floatingActionButton,
              floatingActionButtonLocation:
                  widget?.floatingActionButtonLocation,
              bottomNavigationBar: widget?.bottomNavigationBar,
              bottomSheet: widget?.bottomSheet,
              persistentFooterButtons: widget?.persistentFooterButtons,
              floatingActionButtonAnimator:
                  widget?.floatingActionButtonAnimator,
              resizeToAvoidBottomInset: widget?.resizeToAvoidBottomInset,
              resizeToAvoidBottomPadding: widget?.resizeToAvoidBottomPadding,
              primary: widget?.primary,
              // extendBody: extendBody,
              backgroundColor: widget?.backgroundColor,
              drawer: widget?.drawer,
              endDrawer: widget?.endDrawer,
              appBar: widget?.appBar,
              body: CustomScrollView(
                slivers: <Widget>[]
                  ..addAll(widget.slivers ?? [])
                  ..add(Builder(
                    builder: (BuildContext context) {
                      SliverChildDelegate _childDelagate =
                          widget?.childDelagate;
                      if (_childDelagate?.estimatedChildCount == null &&
                          widget?.nullItems != null)
                        return SliverFillRemaining(child: widget.nullItems);
                      if (_childDelagate?.estimatedChildCount != null &&
                          _childDelagate.estimatedChildCount == 0 &&
                          widget?.emptyItems != null)
                        return SliverFillRemaining(child: widget.emptyItems);
                      return SliverList(
                          delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return new KeepAlive(
                            keepAlive: true,
                            child: new IndexedSemantics(
                              index: index,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _index = index;
                                  });
                                },
                                child: new Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: _childDelagate.build(context, index),
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: _childDelagate?.estimatedChildCount ?? 0,
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        addSemanticIndexes: false,
                      ));
                    },
                  )),
              ),
            ),
          ),
          Flexible(
            flex: widget.flexDetailView,
            child: new _DetailView(
              detailScaffoldKey: widget?.detailScaffoldKey,
              details: _index == null ||
                      _index > widget.childDelagate.estimatedChildCount - 1
                  ? null
                  : widget.detailBuilder(context, _index, true),
              itemNotSelected: widget?.itemNotSelected,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailView extends StatelessWidget {
  const _DetailView({
    Key key,
    @required DetailsScreen details,
    @required this.itemNotSelected,
    @required this.detailScaffoldKey,
  })  : _details = details,
        super(key: key);

  final DetailsScreen _details;
  final Widget itemNotSelected;
  final Key detailScaffoldKey;

  @override
  Widget build(BuildContext context) {
    if (_details == null) {
      return itemNotSelected ??
          Center(
            child: Text("No Item Selected"),
          );
    }
    return Scaffold(
      key: detailScaffoldKey,
      appBar: _details?.appBar,
      body: _details?.body,
    );
  }
}
