import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../../../native_widgets.dart';

typedef RefreshCallback = Future<void> Function();

class CupertinoTableViewController extends StatelessWidget {
  final String title, previousTitle;
  final Widget leading, trailing;
  final ValueChanged<bool> onEditing;
  final RefreshCallback onRefresh;
  final bool showEditingButtonLeft, showEditingButtonRight, hideAppBarOnSearch;
  final bool isEditing, isSearching;
  final List<CupertinoTableViewSection> sections;
  final List<Widget> widgets, toolbarButtons;

  const CupertinoTableViewController({
    @required this.title,
    this.isEditing = false,
    this.isSearching = false,
    this.previousTitle = "Back",
    this.leading,
    this.trailing,
    this.hideAppBarOnSearch = false,
    this.onEditing,
    this.onRefresh,
    this.toolbarButtons,
    this.showEditingButtonLeft = true,
    this.showEditingButtonRight = false,
    @required this.sections,
    this.widgets,
  }) : assert(showEditingButtonLeft != showEditingButtonRight);

  @override
  Widget build(BuildContext context) {
    final _editingButton = Container(
      padding: EdgeInsets.only(top: 10.0),
      child: CupertinoTableViewEditingButton(
        isEditing: isEditing,
        onPressed: () => onEditing(!isEditing),
      ),
    );

    final _searchNavBar = <Widget>[];

    if (!isSearching && hideAppBarOnSearch) {
      _searchNavBar.addAll([
        CupertinoSliverNavigationBar(
//          heroTag: title ?? "Title",
//          transitionBetweenRoutes: false,
          largeTitle: Text(title ?? "Title"),
          // We're specifying a back label here because the previous page
          // is a Material page. CupertinoPageRoutes could auto-populate
          // these back labels.
          previousPageTitle: previousTitle ?? "",
          leading: showEditingButtonLeft ? _editingButton : leading,
          trailing: showEditingButtonRight ? _editingButton : trailing,
        ),
        CupertinoSliverRefreshControl(onRefresh: onRefresh),
      ]);
    }

    final _widgets = <Widget>[];

    if (widgets != null) {
      for (Widget _widget in widgets) {
        _widgets.add(SliverToBoxAdapter(child: _widget));
      }
    }

    final _sections = <Widget>[];

    if (sections != null) {
      int _index = 0;
      for (CupertinoTableViewSection _section in sections) {
        _sections.add(new SliverStickyHeader(
          header: _section?.header == null
              ? null
              : new Container(
                  color: CupertinoColors.lightBackgroundGray,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 5.0),
                  alignment: Alignment.centerLeft,
                  child: _section.header,
                ),
          sliver: SliverSafeArea(
            top: false,
            bottom: sections?.length == _index + 1,
            sliver: SliverList(
              delegate: _section.childrenDelegate,
            ),
          ),
        ));
        _index++;
      }
    }

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.title,
      child: Scaffold(
        body: CustomScrollView(
          primary: true,
          slivers: []
            ..addAll(_searchNavBar)
            ..addAll(_widgets)
            ..addAll(_sections),
        ),
        persistentFooterButtons: toolbarButtons,
      ),
    );
  }
}

class CupertinoTableViewEditingButton extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onPressed;

  const CupertinoTableViewEditingButton({
    this.isEditing,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      return GestureDetector(
        onTap: onPressed,
        child: const Text("Cancel",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CupertinoColors.activeBlue,
            )),
      );
    }
    return GestureDetector(
      onTap: onPressed,
      child: const Text("Edit",
          style: TextStyle(
            color: CupertinoColors.activeBlue,
          )),
    );
  }
}

// Todo; Seconts for Tableview
class CupertinoTableViewSection {
  final Widget header;
  final SliverChildDelegate childrenDelegate;

  const CupertinoTableViewSection({
    this.header,
    @required this.childrenDelegate,
  });
}
