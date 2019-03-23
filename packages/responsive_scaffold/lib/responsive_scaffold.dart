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
    @required this.children,
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
    this.noItems,
    this.nullItems,
    this.tabletItemNotSelected,
    this.tabletSideMenu,
    this.tabletFlexDetailView = 8,
    this.tabletFlexListView = 3,
    this.scaffoldKey,
    this.detailScaffoldKey,
    this.mobileRootNavigator = false,
    this.mobileNavigator,
  })  : itemBuilder = null,
        itemCount = children?.length ?? 0;

  ResponsiveScaffold.builder({
    this.tabletBreakpoint = const Size(480.0, 480.0),
    @required this.detailBuilder,
    this.appBar,
    this.drawer,
    this.slivers,
    this.endDrawer,
    @required this.itemBuilder,
    @required this.itemCount,
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
    this.noItems,
    this.nullItems,
    this.tabletItemNotSelected,
    this.tabletSideMenu,
    this.tabletFlexDetailView = 8,
    this.tabletFlexListView = 4,
    this.scaffoldKey,
    this.detailScaffoldKey,
    this.mobileRootNavigator = false,
    this.mobileNavigator,
  }) : children = null;

  final Size tabletBreakpoint;

  final DetailWidgetBuilder detailBuilder;

  final IndexedWidgetBuilder itemBuilder;

  final int itemCount;

  final PreferredSizeWidget appBar;

  final Widget drawer, endDrawer;

  final List<Widget> slivers;

  final List<Widget> children;

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

  final Widget noItems;

  final Widget nullItems;

  final Widget tabletItemNotSelected;

  final Flexible tabletSideMenu;

  final int tabletFlexListView;

  final int tabletFlexDetailView;

  final bool mobileRootNavigator;

  final NavigatorState mobileNavigator;

  @override
  Widget build(BuildContext context) {
    if (isTablet(context, breakpoint: tabletBreakpoint)) {
      // Tablet
      return TabletView(
        key: key,
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
        children: children,
        itemBuilder: itemBuilder,
        itemCount: itemCount,
        noItems: noItems,
        flexDetailView: tabletFlexDetailView,
        flexListView: tabletFlexListView,
        sideMenu: tabletSideMenu,
        nullItems: nullItems,
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
      body: MobileView(
        useRootNavigator: mobileRootNavigator,
        slivers: slivers,
        detailScaffoldKey: detailScaffoldKey,
        detailBuilder: detailBuilder,
        children: children,
        itemBuilder: itemBuilder,
        itemCount: itemCount,
        noItems: noItems,
        nullItems: nullItems,
        navigator: mobileNavigator,
      ),
    );
  }
}

typedef DetailWidgetBuilder = DetailsScreen Function(
    BuildContext context, int index, bool tablet);
