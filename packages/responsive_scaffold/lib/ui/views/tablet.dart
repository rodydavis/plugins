import 'package:flutter/gestures.dart';
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
  final int flexListView;
  final int flexDetailView;

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

  @override
  _TabletViewState createState() => _TabletViewState();
}

class _TabletViewState extends State<TabletView> {
  DetailsScreen _details;
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
              body: widget?.itemCount == null
                  ? widget?.nullItems ??
                      Center(child: CircularProgressIndicator())
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
                                        _details = widget.detailBuilder(
                                            context, index, true);
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
          ),
          Flexible(
            flex: widget.flexDetailView,
            child: new DetailView(
              detailScaffoldKey: widget?.detailScaffoldKey,
              details: _details,
              itemNotSelected: widget?.itemNotSelected,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailView extends StatelessWidget {
  const DetailView({
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
