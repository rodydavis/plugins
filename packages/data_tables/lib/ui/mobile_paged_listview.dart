import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cupertino;

class PagedListView extends StatefulWidget {
  const PagedListView({
    @required this.rows,
    @required this.columns,
    this.mobileItemBuilder,
    this.selectedActions,
    this.actions,
    this.onSelectAll,
    this.rowsPerPage,
    this.loadNext,
    this.sortColumnIndex,
    this.sortAscending,
    this.onRefresh,
    this.isRowCountApproximate = false,
    this.initialScrollOffset = 0,
    this.noItems,
    this.isLoading,
    this.slivers,
  });

  final double initialScrollOffset;

  final List<DataColumn> columns;

  final List<DataRow> rows;

  final IndexedWidgetBuilder mobileItemBuilder;

  final List<Widget> actions, selectedActions;

  final ValueChanged<bool> onSelectAll;

  final int rowsPerPage;

  final VoidCallback loadNext;

  final int sortColumnIndex;

  final bool sortAscending;

  final Widget noItems, isLoading;

  final RefreshCallback onRefresh;

  final bool isRowCountApproximate;

  final List<Widget> slivers;

  @override
  _NativePagedListViewState createState() => _NativePagedListViewState();
}

class _NativePagedListViewState extends State<PagedListView> {
  ScrollController _controller;
  PersistentBottomSheetController _sortController;

  @override
  void initState() {
    _controller = ScrollController(
      initialScrollOffset: widget.initialScrollOffset * 40.0,
    );
    _controller.addListener(_scrollListener);

    super.initState();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      // Bottom of List
      widget?.loadNext();
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      // Top of List
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: CustomScrollView(
            controller: _controller,
            slivers: <Widget>[]
              ..addAll(widget?.slivers ?? [])
              ..add(widget?.onRefresh == null
                  ? SliverToBoxAdapter(child: Container())
                  : cupertino.CupertinoSliverRefreshControl(
                      onRefresh: widget?.onRefresh,
                    ))
              ..add(widget?.isLoading != null && widget?.rows == null
                  ? Center(child: widget.isLoading)
                  : widget?.noItems != null && widget.rows.isEmpty
                      ? Center(child: widget.noItems)
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            widget?.mobileItemBuilder ??
                                (BuildContext context, int index) {
                                  return ExpansionTile(
                                    leading: Checkbox(
                                      value: widget.rows[index].selected,
                                      onChanged: (bool value) {
                                        setState(() {
                                          widget.rows[index]
                                              .onSelectChanged(value);
                                        });
                                      },
                                    ),
                                    title: widget.rows[index].cells.first.child,
                                    children: _buildMobileChildren(index),
                                  );
                                },
                            childCount: widget.rows.length,
                          ),
                        )),
          ),
        ),
        SafeArea(
          top: false,
          child: Container(
            decoration: BoxDecoration(
                border: Border(
              top: cupertino.BorderSide(color: Colors.grey[200]),
            )),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: rowsSelected ? selectedActions ?? actions : actions,
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> get actions => [
        IconButton(
          icon: Icon(Icons.select_all),
          onPressed: () {
            setState(() {
              widget?.onSelectAll(true);
            });
          },
        ),
        IconButton(
          tooltip: "Sort Items",
          icon: Icon(Icons.sort_by_alpha),
          onPressed: () {
            if (_sortController != null) {
              _sortController.close();
              print("Close...");
              return;
            }

            _sortController = Scaffold.of(context).showBottomSheet((context) {
              final List<DataColumn> _cols =
                  widget.columns.where((c) => c?.onSort != null)?.toList();
              final bool _sortAsc = widget.sortAscending;
              final int selectedIndex = widget.sortColumnIndex;
              return Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black38
                        : Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      for (var i = 0; i < _cols.length; i++) ...[
                        ListTile(
                          dense: true,
                          selected: selectedIndex == i,
                          title: _cols[i].label,
                          subtitle: Text(widget.sortAscending
                              ? 'Ascending'
                              : 'Descending'),
                          leading: Radio<int>(
                            groupValue: selectedIndex,
                            onChanged: (value) {
                              _sortController.setState(() {
                                _cols[i].onSort(i, _sortAsc);
                              });
                            },
                            value: i,
                          ),
                          trailing: IconButton(
                            icon: Icon(_sortAsc
                                ? Icons.arrow_upward
                                : Icons.arrow_downward),
                            onPressed: () {
                              _sortController.setState(() {
                                _cols[i].onSort(i, !_sortAsc);
                              });
                            },
                          ),
                          onTap: () {
                            if (selectedIndex == i) {
                              _sortController.setState(() {
                                _cols[i].onSort(i, !_sortAsc);
                              });
                            } else {
                              _sortController.setState(() {
                                _cols[i].onSort(i, _sortAsc);
                              });
                            }
                          },
                        ),
                      ],
                      Container(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Container(
                          child: FlatButton(
                            child: Text(
                              "Close",
                              style: Theme.of(context).textTheme.headline,
                            ),
                            onPressed: () {
                              _sortController.close();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });

            _sortController.closed.whenComplete(() {
              print("Done");
              _sortController = null;
            });
          },
        ),
        Container(
          child: widget?.onRefresh == null
              ? null
              : IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: widget.onRefresh,
                ),
        ),
      ]..addAll(widget?.actions);
  List<Widget> get selectedActions => [
        IconButton(
          icon: Icon(Icons.clear_all),
          onPressed: () {
            setState(() {
              widget?.onSelectAll(false);
            });
          },
        ),
      ]..addAll(widget?.selectedActions);

  bool get rowsSelected => _selectedRowCount != 0;

  int get _selectedRowCount =>
      widget.rows
          ?.where((d) => d?.selected ?? false)
          ?.toSet()
          ?.toList()
          ?.length ??
      0;

  List<Widget> _buildMobileChildren(int index) {
    List<Widget> _children = [];
    int i = 0;
    for (var _cell in widget.rows[index].cells) {
      _children.add(ListTile(
        title: widget.columns[i].label,
        subtitle: _cell.child,
      ));
      i++;
    }
    return _children;
  }
}
