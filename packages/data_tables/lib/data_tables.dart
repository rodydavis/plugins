import 'package:flutter/material.dart';

import 'ui/mobile_paged_listview.dart';
import 'ui/stateless_datatable.dart';

class NativeDataTable extends StatelessWidget {
//   @override
//   _DataTableDemoState createState() => _DataTableDemoState();
// }

// class _DataTableDemoState extends State<DataTableDemo> {
//   int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
//   int _sortColumnIndex;
//   bool _sortAscending = true;
//   final DessertDataSource _dessertsDataSource = DessertDataSource();

//   void _sort<T>(
//       Comparable<T> getField(Dessert d), int columnIndex, bool ascending) {
//     _dessertsDataSource._sort<T>(getField, ascending);
//     setState(() {
//       _sortColumnIndex = columnIndex;
//       _sortAscending = ascending;
//     });
//   }

  const NativeDataTable({
    @required this.columns,
    @required this.rows,
    this.rowsPerPage = PaginatedDataTable.defaultRowsPerPage,
    this.header,
    this.onRowsPerPageChanged,
    this.onSelectAll,
    this.sortAscending,
    this.sortColumnIndex,
    this.mobileItemBuilder,
    this.tabletBreakpoint = const Size(480.0, 480.0),
    this.actions,
    this.firstRowIndex = 0,
    this.selectedActions,
    this.showMobileListView = true,
    this.onRefresh,
    this.mobileFetchNextRows = 100,
    this.handlePrevious,
    this.handleNext,
    this.rowCountApproximate = false,
    this.noItems,
    this.mobileIsLoading,
  });

  NativeDataTable.builder({
    @required this.columns,
    this.rowsPerPage = PaginatedDataTable.defaultRowsPerPage,
    @required int itemCount,
    @required DataRowBuilder itemBuilder,
    this.header,
    this.onRowsPerPageChanged,
    this.onSelectAll,
    this.sortAscending,
    this.sortColumnIndex,
    this.mobileItemBuilder,
    this.tabletBreakpoint = const Size(480.0, 480.0),
    this.actions,
    this.selectedActions,
    this.showMobileListView = true,
    this.firstRowIndex = 0,
    this.onRefresh,
    this.mobileFetchNextRows = 100,
    this.handlePrevious,
    this.handleNext,
    this.rowCountApproximate = false,
    this.noItems,
    this.mobileIsLoading,
  }) : rows = _buildRows(itemCount, itemBuilder);

  final bool showMobileListView;

  final int sortColumnIndex;

  final bool sortAscending;

  final ValueChanged<bool> onSelectAll;

  final ValueChanged<int> onRowsPerPageChanged;

  final int rowsPerPage;

  final int firstRowIndex;

  /// Visible on Tablet/Desktop
  final Widget header;

  final List<DataColumn> columns;

  final List<DataRow> rows;

  final IndexedWidgetBuilder mobileItemBuilder;

  final Size tabletBreakpoint;

  final List<Widget> actions, selectedActions;

  final int mobileFetchNextRows;

  final RefreshCallback onRefresh;

  final VoidCallback handlePrevious, handleNext;

  /// Set this to [true] for using this with a api
  final bool rowCountApproximate;

  final Widget noItems;

  final Widget mobileIsLoading;

  @override
  Widget build(BuildContext context) {
    if (showMobileListView &&
        (MediaQuery.of(context).size.width <= tabletBreakpoint.width ||
            MediaQuery.of(context).size.height <= tabletBreakpoint.height)) {
      return PagedListView(
        rows: rows,
        columns: columns,
        loadNext: handleNext,
        mobileItemBuilder: mobileItemBuilder,
        actions: actions,
        selectedActions: selectedActions,
        onSelectAll: onSelectAll,
        rowsPerPage: rowsPerPage,
        sortAscending: sortAscending,
        sortColumnIndex: sortColumnIndex,
        onRefresh: onRefresh,
        isRowCountApproximate: rowCountApproximate,
        isLoading: mobileIsLoading,
        noItems: noItems,
      );
    }

    return StatelessDataTable(
      rows: rows,
      firstRowIndex: firstRowIndex,
      header: header ?? Container(),
      handleNext: handleNext,
      handlePrevious: handlePrevious,
      rowsPerPage: rowsPerPage,
      onRowsPerPageChanged: onRowsPerPageChanged,
      sortColumnIndex: sortColumnIndex,
      sortAscending: sortAscending,
      onSelectAll: onSelectAll,
      columns: columns,
      shrinkWrap: false,
      rowCountApproximate: rowCountApproximate,
      actions: []
        ..addAll(actions)
        ..add(Container(
          child: onRefresh == null
              ? null
              : IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: onRefresh,
                ),
        )),
      selectedActions: selectedActions,
    );
  }

  static List<DataRow> _buildRows(int count, DataRowBuilder builder) {
    List<DataRow> _rows = [];

    for (int i = 0; i < count; i++) {
      _rows.add(builder(i));
    }

    return _rows;
  }
}

typedef DataRowBuilder = DataRow Function(int index);
