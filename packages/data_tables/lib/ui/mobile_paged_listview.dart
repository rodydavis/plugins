import 'package:flutter/material.dart';

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
    return SafeArea(
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Flexible(
            flex: 10,
            child: widget?.onRefresh == null
                ? _buildListView(context)
                : RefreshIndicator(
                    onRefresh: widget.onRefresh,
                    child: _buildListView(context)),
          ),
          Flexible(
              flex: 1,
              child: Container(
                child: SafeArea(
                  child: Row(
                    children:
                        rowsSelected ? selectedActions ?? actions : actions,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    if (widget?.isLoading != null && widget?.rows == null)
      return Center(child: widget.isLoading);

    if (widget?.noItems != null && widget.rows.isEmpty)
      return Center(child: widget.noItems);

    return Scrollbar(
      child: ListView.builder(
        controller: _controller,
        itemCount: widget.rows.length,
        itemBuilder: widget?.mobileItemBuilder ??
            (BuildContext context, int index) {
              return ExpansionTile(
                leading: Checkbox(
                  value: widget.rows[index].selected,
                  onChanged: (bool value) {
                    setState(() {
                      widget.rows[index].onSelectChanged(value);
                    });
                  },
                ),
                title: widget.rows[index].cells.first.child,
                children: _buildMobileChildren(index),
              );
            },
      ),
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
              final double _perferredHeight =
                  MediaQuery.of(context).size.height;
              final double _columnsHeight = widget.columns.length * 70.0;
              final List<DataColumn> _cols =
                  widget.columns.where((c) => c?.onSort != null)?.toList();
              return Container(
                height: _columnsHeight >= _perferredHeight
                    ? _perferredHeight
                    : _columnsHeight,
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black38
                        : Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    )),
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Flexible(
                      flex: 8,
                      child: Scrollbar(
                        child: ListView.builder(
                          itemCount: _cols.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            final col = _cols[index];
                            final bool _sortAsc = widget.sortAscending;
                            final int selectedIndex = widget.sortColumnIndex;
                            return ListTile(
                              dense: true,
                              selected: selectedIndex == index,
                              title: col.label,
                              subtitle: Text(widget.sortAscending
                                  ? 'Ascending'
                                  : 'Descending'),
                              leading: Radio<int>(
                                groupValue: selectedIndex,
                                onChanged: (value) {
                                  _sortController.setState(() {
                                    col.onSort(index, _sortAsc);
                                  });
                                },
                                value: index,
                              ),
                              trailing: IconButton(
                                icon: Icon(_sortAsc
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward),
                                onPressed: () {
                                  _sortController.setState(() {
                                    col.onSort(index, !_sortAsc);
                                  });
                                },
                              ),
                              onTap: () {
                                if (selectedIndex == index) {
                                  _sortController.setState(() {
                                    col.onSort(index, !_sortAsc);
                                  });
                                } else {
                                  _sortController.setState(() {
                                    col.onSort(index, _sortAsc);
                                  });
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(top: 10.0),
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
