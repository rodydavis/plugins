import 'package:data_tables/ui/mobile_paged_listview.dart';
import 'package:flutter/material.dart';

import 'ui/custom_paged_table.dart';

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
    @required this.dataSource,
    @required this.rowsPerPage,
    this.header,
    this.onRowsPerPageChanged,
    this.onSelectAll,
    this.sortAscending,
    this.sortColumnIndex,
    this.mobileItemBuilder,
    this.tabletBreakpoint = 480.0,
    this.actions,
    this.selectedActions,
    this.showMobileListView = true,
    this.onRefresh,
    this.mobileFetchNextRows = 100,
  });

  final bool showMobileListView;

  final int sortColumnIndex;

  final bool sortAscending;

  final ValueChanged<bool> onSelectAll;

  final ValueChanged<int> onRowsPerPageChanged;

  final int rowsPerPage;

  /// Visible on Tablet/Desktop
  final Widget header;

  final List<DataColumn> columns;

  final DataTableSource dataSource;

  final IndexedWidgetBuilder mobileItemBuilder;

  final num tabletBreakpoint;

  final List<Widget> actions, selectedActions;

  final int mobileFetchNextRows;

  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    if (showMobileListView &&
        MediaQuery.of(context).size.width < tabletBreakpoint) {
      return NativePagedListView(
        dataSource: dataSource,
        columns: columns,
        mobileItemBuilder: mobileItemBuilder,
        actions: actions,
        selectedActions: selectedActions,
        onRowsPerPageChanged: onRowsPerPageChanged,
        onSelectAll: onSelectAll,
        rowsPerPage: rowsPerPage,
        mobileFetchNextRows: mobileFetchNextRows,
        sortAscending: sortAscending,
        sortColumnIndex: sortColumnIndex,
        onRefresh: onRefresh,
      );
    }

    return CustomPaginatedDataTable(
      header: header ?? Container(),
      rowsPerPage: rowsPerPage,
      onRowsPerPageChanged: onRowsPerPageChanged,
      sortColumnIndex: sortColumnIndex,
      sortAscending: sortAscending,
      onSelectAll: onSelectAll,
      columns: columns,
      source: dataSource,
      shrinkWrap: false,
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
}
