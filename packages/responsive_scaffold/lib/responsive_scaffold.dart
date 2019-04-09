import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'data/classes/details.dart';
import 'ui/views/mobile.dart';
import 'ui/views/tablet.dart';
import 'utils/breakpoint.dart';

export 'package:responsive_scaffold/data/classes/details.dart';

class ResponsiveScaffold extends StatelessWidget {
  ResponsiveScaffold({
    this.tabletBreakpoint = const Size(480.0, 480.0),
    @required this.detailBuilder,
    this.appBar,
    this.drawer,
    this.slivers,
    this.endDrawer,
    @required List<Widget> children,
    this.primary = true,
    // this.extendBody = false,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.floatingActionButton,
    this.floatingActionButtonAnimator,
    this.floatingActionButtonLocation,
    this.persistentFooterButtons,
    this.resizeToAvoidBottomInset,
    this.resizeToAvoidBottomPadding,
    this.tabletItemNotSelected,
    this.tabletSideMenu,
    this.nullItems,
    this.emptyItems,
    this.tabletFlexDetailView = 8,
    this.tabletFlexListView = 3,
    this.scaffoldKey,
    this.detailScaffoldKey,
    this.mobileRootNavigator = false,
    this.mobileNavigator,
  }) : childDelagate = SliverChildListDelegate(
          children ?? <Widget>[nullItems ?? Center(child: CircularProgressIndicator())],
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          addSemanticIndexes: false,
        );

  ResponsiveScaffold.builder({
    this.tabletBreakpoint = const Size(480.0, 480.0),
    @required this.detailBuilder,
    this.appBar,
    this.drawer,
    this.slivers,
    this.endDrawer,
    @required int itemCount,
    @required IndexedWidgetBuilder itemBuilder,
    this.primary = true,
    // this.extendBody = false,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.floatingActionButton,
    this.nullItems,
    this.emptyItems,
    this.floatingActionButtonAnimator,
    this.floatingActionButtonLocation,
    this.persistentFooterButtons,
    this.resizeToAvoidBottomInset,
    this.resizeToAvoidBottomPadding,
    this.tabletItemNotSelected,
    this.tabletSideMenu,
    this.tabletFlexDetailView = 8,
    this.tabletFlexListView = 4,
    this.scaffoldKey,
    this.detailScaffoldKey,
    this.mobileRootNavigator = false,
    this.mobileNavigator,
  }) : childDelagate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          addSemanticIndexes: false,
        );

  ResponsiveScaffold.custom({
    this.tabletBreakpoint = const Size(480.0, 480.0),
    @required this.detailBuilder,
    this.appBar,
    this.drawer,
    this.slivers,
    this.endDrawer,
    @required this.childDelagate,
    this.primary = true,
    // this.extendBody = false,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.floatingActionButton,
    this.nullItems,
    this.emptyItems,
    this.floatingActionButtonAnimator,
    this.floatingActionButtonLocation,
    this.persistentFooterButtons,
    this.resizeToAvoidBottomInset,
    this.resizeToAvoidBottomPadding,
    this.tabletItemNotSelected,
    this.tabletSideMenu,
    this.tabletFlexDetailView = 8,
    this.tabletFlexListView = 4,
    this.scaffoldKey,
    this.detailScaffoldKey,
    this.mobileRootNavigator = false,
    this.mobileNavigator,
  });

  final Size tabletBreakpoint;

  final DetailWidgetBuilder detailBuilder;

  final PreferredSizeWidget appBar;

  final Widget drawer, endDrawer;

  final List<Widget> slivers;

  final Widget floatingActionButton;

  final FloatingActionButtonLocation floatingActionButtonLocation;

  final Widget bottomNavigationBar;

  final Widget bottomSheet;

  final List<Widget> persistentFooterButtons;

  final FloatingActionButtonAnimator floatingActionButtonAnimator;

  final bool resizeToAvoidBottomPadding;

  final bool resizeToAvoidBottomInset;

  final bool primary;

  // final bool extendBody;

  final DragStartBehavior drawerDragStartBehavior;

  final Color backgroundColor;

  final Key scaffoldKey, detailScaffoldKey;

  final Widget tabletItemNotSelected;

  final Flexible tabletSideMenu;

  final int tabletFlexListView;

  final int tabletFlexDetailView;

  final bool mobileRootNavigator;

  final NavigatorState mobileNavigator;

  final Widget nullItems, emptyItems;

  final SliverChildDelegate childDelagate;

  @override
  Widget build(BuildContext context) {
    if (isTablet(context, breakpoint: tabletBreakpoint)) {
      // Tablet
      return TabletView.custom(
        key: key,
        nullItems: nullItems,
        emptyItems: emptyItems,
        scaffoldkey: scaffoldKey,
        detailScaffoldKey: detailScaffoldKey,
        drawerDragStartBehavior: drawerDragStartBehavior,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: bottomNavigationBar,
        bottomSheet: bottomSheet,
        persistentFooterButtons: persistentFooterButtons,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        resizeToAvoidBottomPadding: resizeToAvoidBottomPadding,
        primary: primary,
        // extendBody: extendBody,
        backgroundColor: backgroundColor,
        drawer: drawer,
        endDrawer: endDrawer,
        appBar: appBar,
        slivers: slivers,
        detailBuilder: detailBuilder,
        childDelagate: childDelagate,
        flexDetailView: tabletFlexDetailView,
        flexListView: tabletFlexListView,
        sideMenu: tabletSideMenu,
        itemNotSelected: tabletItemNotSelected,
      );
    }

    // Mobile
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      persistentFooterButtons: persistentFooterButtons,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      resizeToAvoidBottomPadding: resizeToAvoidBottomPadding,
      primary: primary,
      // extendBody: extendBody,
      backgroundColor: backgroundColor,
      drawer: drawer,
      endDrawer: endDrawer,
      appBar: appBar,
      body: MobileView.custom(
        useRootNavigator: mobileRootNavigator,
        nullItems: nullItems,
        emptyItems: emptyItems,
        slivers: slivers,
        detailScaffoldKey: detailScaffoldKey,
        detailBuilder: detailBuilder,
        childDelagate: childDelagate,
        navigator: mobileNavigator,
      ),
    );
  }
}

typedef DetailWidgetBuilder = DetailsScreen Function(
    BuildContext context, int index, bool tablet);
