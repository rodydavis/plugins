import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

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

  CupertinoTableViewController({
    this.previousTitle,
    this.title,
    this.trailing,
    this.leading,
    this.onRefresh,
    this.hideAppBarOnSearch = false,
    this.isSearching = false,
    this.isEditing = false,
    this.onEditing,
    List<Widget> children = const <Widget>[],
    this.widgets,
    this.showEditingButtonLeft = true,
    this.showEditingButtonRight = false,
    this.toolbarButtons,
  })  : sections = [CupertinoTableViewSection(children: children)],
        assert(showEditingButtonLeft != showEditingButtonRight);

  CupertinoTableViewController.builder({
    // this.item,

    this.previousTitle,
    this.title,
    this.trailing,
    this.leading,
    this.onRefresh,
    this.hideAppBarOnSearch = false,
    this.isSearching = false,
    this.isEditing = false,
    this.onEditing,
    @required IndexedWidgetBuilder itemBuilder,
    int itemCount,
    this.widgets,
    this.showEditingButtonLeft = true,
    this.showEditingButtonRight = false,
    this.toolbarButtons,
  })  : sections = [
          CupertinoTableViewSection.builder(
            itemBuilder: itemBuilder,
            itemCount: itemCount,
          )
        ],
        assert(showEditingButtonLeft != showEditingButtonRight);

  const CupertinoTableViewController.sectioned({
    this.previousTitle,
    this.title,
    this.trailing,
    this.hideAppBarOnSearch = false,
    this.leading,
    this.onRefresh,
    this.isSearching = false,
    this.isEditing = false,
    this.onEditing,
    this.showEditingButtonLeft = true,
    this.showEditingButtonRight = false,
    this.toolbarButtons,
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

  CupertinoTableViewSection({
    this.header,
   List<Widget> children = const <Widget>[],
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
  }) : childrenDelegate = SliverChildListDelegate(
          children,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        );

  CupertinoTableViewSection.builder({
    this.header,
    @required IndexedWidgetBuilder itemBuilder,
    int itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
  }) : childrenDelegate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        );
}
