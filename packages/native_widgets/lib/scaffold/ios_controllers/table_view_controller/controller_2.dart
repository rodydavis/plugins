import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:uuid/uuid.dart';
import '../../../common/search/cupertino_search_bar.dart';

import '../../../native_widgets.dart';
import '../../../utils/ios_search_bar.dart';
import 'cell.dart';

typedef RefreshCallback = Future<void> Function();

class CupertinoTableViewController extends StatelessWidget {
  final String title, previousTitle;
  final Widget leading, trailing;
  final ValueChanged<bool> onEditing, onSearch;
  final RefreshCallback onRefresh;
  final ValueChanged<String> onChanged;
  final String initialValue;
  final VoidCallback onSearchPressed, onSelectAll, onDeleteAll;
  final bool showSearchBar, showEditingButtonLeft, showEditingButtonRight;
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
    this.onSearch,
    this.onEditing,
    this.onRefresh,
    this.initialValue = "",
    this.onChanged,
    this.onSearchPressed,
    this.showSearchBar = false,
    this.onDeleteAll,
    this.onSelectAll,
    this.toolbarButtons,
    this.showEditingButtonLeft = true,
    this.showEditingButtonRight = false,
    @required this.sections,
    this.widgets,
  }) : assert(showEditingButtonLeft != showEditingButtonRight);

  @override
  Widget build(BuildContext context) {
    // FocusScope.of(context).requestFocus(_searchFocusNode);
    final _editingButton = Container(
      padding: EdgeInsets.only(top: 10.0),
      child: CupertinoTableViewEditingButton(
        isEditing: isEditing,
        onPressed: () => onEditing(!isEditing),
      ),
    );

    final _list = <Widget>[];

    if (!isSearching) {
      _list.addAll([
        CupertinoSliverNavigationBar(
          heroTag: title ?? "Title",
          transitionBetweenRoutes: false,
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

    if (showSearchBar) {
      _list.add(SliverSafeArea(
        bottom: false,
        top: isSearching,
        sliver: SliverToBoxAdapter(
          child: CupertinoSearchBar(
            initialValue: "",
            onChanged: onChanged,
            alwaysShowAppBar: true,
            onSearching: onSearch,
          ),
        ),
      ));
    }

    if (widgets != null) {
      for (Widget _widget in widgets) {
        _list.add(SliverToBoxAdapter(child: _widget));
      }
    }

    if (sections != null) {
      int _index = 0;
      for (CupertinoTableViewSection _section in sections) {
        _list.add(new SliverStickyHeader(
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
        body: CustomScrollView(primary: true, slivers: _list),
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
