import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// A material design data table that shows data using multiple pages.
///
/// A paginated data table shows [rowsPerPage] rows of data per page and
/// provides controls for showing other pages.
///
/// Data is read lazily from from a [DataTableSource]. The widget is presented
/// as a [Card].
///
/// See also:
///
///  * [DataTable], which is not paginated.
///  * <https://material.io/go/design-data-tables#data-tables-tables-within-cards>
class StatelessDataTable extends StatelessWidget {
  /// Creates a widget describing a paginated [DataTable] on a [Card].
  ///
  /// The [header] should give the card's header, typically a [Text]  It
  /// must not be null.
  ///
  /// The [columns] argument must be a list of as many [DataColumn] objects as
  /// the table is to have columns, ignoring the leading checkbox column if any.
  /// The [columns] argument must have a length greater than zero and cannot be
  /// null.
  ///
  /// If the table is sorted, the column that provides the current primary key
  /// should be specified by index in [sortColumnIndex], 0 meaning the first
  /// column in [columns], 1 being the next one, and so forth.
  ///
  /// The actual sort order can be specified using [sortAscending]; if the sort
  /// order is ascending, this should be true (the default), otherwise it should
  /// be false.
  ///
  /// The [source] must not be null. The [source] should be a long-lived
  /// [DataTableSource]. The same source should be provided each time a
  /// particular [StatelessDataTable] widget is created; avoid creating a new
  /// [DataTableSource] with each new instance of the [StatelessDataTable]
  /// widget unless the data table really is to now show entirely different
  /// data from a new source.
  ///
  /// The [rowsPerPage] and [availableRowsPerPage] must not be null (they
  /// both have defaults, though, so don't have to be specified).
  StatelessDataTable({
    Key key,
    @required this.header,
    this.actions,
    @required this.columns,
    @required this.rows,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.onSelectAll,
    this.firstRowIndex = 0,
    this.onPageChanged,
    this.shrinkWrap = false,
    this.selectedActions,
    this.rowCountApproximate = false,
    this.rowsPerPage = defaultRowsPerPage,
    this.handlePrevious,
    this.handleNext,
    this.availableRowsPerPage = const <int>[
      defaultRowsPerPage,
      defaultRowsPerPage * 2,
      defaultRowsPerPage * 5,
      defaultRowsPerPage * 10
    ],
    this.onRowsPerPageChanged,
    this.dragStartBehavior = DragStartBehavior.down,
  })  : assert(header != null),
        assert(columns != null),
        assert(dragStartBehavior != null),
        assert(columns.isNotEmpty),
        assert(sortColumnIndex == null ||
            (sortColumnIndex >= 0 && sortColumnIndex < columns.length)),
        assert(sortAscending != null),
        assert(rowsPerPage != null),
        assert(rowsPerPage > 0),
        assert(() {
          if (onRowsPerPageChanged != null)
            assert(availableRowsPerPage != null &&
                availableRowsPerPage.contains(rowsPerPage));
          return true;
        }()),
        super(key: key);

  final VoidCallback handleNext, handlePrevious;

  /// The table card's header.
  ///
  /// This is typically a [Text] widget, but can also be a [ButtonBar] with
  /// [FlatButton]s. Suitable defaults are automatically provided for the font,
  /// button color, button padding, and so forth.
  ///
  /// If items in the table are selectable, then, when the selection is not
  /// empty, the header is replaced by a count of the selected items.
  final Widget header;

  /// Icon buttons to show at the top right of the table.
  ///
  /// Typically, the exact actions included in this list will vary based on
  /// whether any rows are selected or not.
  ///
  /// These should be size 24.0 with default padding (8.0).
  final List<Widget> actions, selectedActions;

  /// The configuration and labels for the columns in the table.
  final List<DataColumn> columns;

  /// The configuration and labels for the rows in the table.
  final List<DataRow> rows;

  final bool shrinkWrap;

  /// The current primary sort key's column.
  ///
  /// See [DataTable.sortColumnIndex].
  final int sortColumnIndex;

  /// Whether the column mentioned in [sortColumnIndex], if any, is sorted
  /// in ascending order.
  ///
  /// See [DataTable.sortAscending].
  final bool sortAscending;

  /// Invoked when the user selects or unselects every row, using the
  /// checkbox in the heading row.
  ///
  /// See [DataTable.onSelectAll].
  final ValueSetter<bool> onSelectAll;

  /// Invoked when the user switches to another page.
  ///
  /// The value is the index of the first row on the currently displayed page.
  final ValueChanged<int> onPageChanged;

  /// The number of rows to show on each page.
  ///
  /// See also:
  ///
  ///  * [onRowsPerPageChanged]
  ///  * [defaultRowsPerPage]
  final int rowsPerPage;

  /// The default value for [rowsPerPage].
  ///
  /// Useful when initializing the field that will hold the current
  /// [rowsPerPage], when implemented [onRowsPerPageChanged].
  static const int defaultRowsPerPage = 10;

  /// The options to offer for the rowsPerPage.
  ///
  /// The current [rowsPerPage] must be a value in this list.
  ///
  /// The values in this list should be sorted in ascending order.
  final List<int> availableRowsPerPage;

  /// Invoked when the user selects a different number of rows per page.
  ///
  /// If this is null, then the value given by [rowsPerPage] will be used
  /// and no affordance will be provided to change the value.
  final ValueChanged<int> onRowsPerPageChanged;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  final int firstRowIndex;

  final bool rowCountApproximate;

  final Map<int, DataRow> _rows = <int, DataRow>{};

  DataRow _getBlankRowFor(int index) {
    return DataRow.byIndex(
        index: index,
        cells: columns
            .map<DataCell>((DataColumn column) => DataCell.empty)
            .toList());
  }

  DataRow _getProgressIndicatorRowFor(int index) {
    bool haveProgressIndicator = false;
    final List<DataCell> cells = columns.map<DataCell>((DataColumn column) {
      if (!column.numeric) {
        haveProgressIndicator = true;
        return const DataCell(CircularProgressIndicator());
      }
      return DataCell.empty;
    }).toList();
    if (!haveProgressIndicator) {
      haveProgressIndicator = true;
      cells[0] = const DataCell(CircularProgressIndicator());
    }
    return DataRow.byIndex(index: index, cells: cells);
  }

  List<DataRow> _getRows(int firstRowIndex, int rowsPerPage) {
    final List<DataRow> result = <DataRow>[];
    final int nextPageFirstRowIndex = firstRowIndex + rowsPerPage;
    bool haveProgressIndicator = false;
    for (int index = firstRowIndex; index < nextPageFirstRowIndex; index += 1) {
      DataRow row;
      if (index < rows.length || rowCountApproximate) {
        try {
          row = _rows.putIfAbsent(index, () => rows[index]);
        } catch (e) {
          print("Row not found => $e");
        }
        if (row == null && !haveProgressIndicator) {
          row ??= _getProgressIndicatorRowFor(index);
          haveProgressIndicator = true;
        }
      }
      row ??= _getBlankRowFor(index);
      result.add(row);
    }
    return result;
  }

  final GlobalKey _tableKey = GlobalKey();

  int get _selectedRowCount =>
      rows?.where((d) => d?.selected ?? false)?.toSet()?.toList()?.length ?? 0;

  @override
  Widget build(BuildContext context) {
    // This whole build function doesn't handle RTL yet.
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData themeData = Theme.of(context);
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    // HEADER
    final List<Widget> headerWidgets = <Widget>[];
    double startPadding = 24.0;
    if (_selectedRowCount == 0) {
      headerWidgets.add(Expanded(child: header));
      if (header is ButtonBar) {
        // We adjust the padding when a button bar is present, because the
        // ButtonBar introduces 2 pixels of outside padding, plus 2 pixels
        // around each button on each side, and the button itself will have 8
        // pixels internally on each side, yet we want the left edge of the
        // inside of the button to line up with the 24.0 left inset.
        // Better magic. See https://github.com/flutter/flutter/issues/4460
        startPadding = 12.0;
      }
    } else {
      headerWidgets.add(Expanded(
        child: Text(localizations.selectedRowCountTitle(_selectedRowCount)),
      ));
    }
    if (selectedActions != null && _selectedRowCount != 0) {
      headerWidgets.addAll(selectedActions.map<Widget>((Widget action) {
        return Padding(
          // 8.0 is the default padding of an icon button
          padding: const EdgeInsetsDirectional.only(start: 24.0 - 8.0 * 2.0),
          child: action,
        );
      }).toList());
    } else if (actions != null) {
      headerWidgets.addAll(actions.map<Widget>((Widget action) {
        return Padding(
          // 8.0 is the default padding of an icon button
          padding: const EdgeInsetsDirectional.only(start: 24.0 - 8.0 * 2.0),
          child: action,
        );
      }).toList());
    }

    // FOOTER
    final TextStyle footerTextStyle = themeData.textTheme.caption;
    final List<Widget> footerWidgets = <Widget>[];
    if (onRowsPerPageChanged != null) {
      final List<Widget> _footerChildren = availableRowsPerPage
          .where((int value) => value <= rows.length || value == rowsPerPage)
          .map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(value: value, child: Text('$value'));
      }).toList();
      footerWidgets.addAll(<Widget>[
        Container(
            width:
                14.0), // to match trailing padding in case we overflow and end up scrolling
        Text(localizations.rowsPerPageTitle),
        ConstrainedBox(
          constraints: const BoxConstraints(
              minWidth: 64.0), // 40.0 for the text, 24.0 for the icon
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                items: _footerChildren,
                value: rowsPerPage,
                onChanged: onRowsPerPageChanged,
                style: footerTextStyle,
                iconSize: 24.0,
              ),
            ),
          ),
        ),
      ]);
    }
    footerWidgets.addAll(<Widget>[
      Container(width: 32.0),
      Text(localizations.pageRowsInfoTitle(firstRowIndex + 1,
          firstRowIndex + rowsPerPage, rows.length, rowCountApproximate)),
      Container(width: 32.0),
      IconButton(
          icon: const Icon(Icons.chevron_left),
          padding: EdgeInsets.zero,
          tooltip: localizations.previousPageTooltip,
          onPressed: firstRowIndex <= 0 ? null : handlePrevious),
      Container(width: 24.0),
      IconButton(
          icon: const Icon(Icons.chevron_right),
          padding: EdgeInsets.zero,
          tooltip: localizations.nextPageTooltip,
          onPressed: (!rowCountApproximate &&
                  (firstRowIndex + rowsPerPage >= rows.length))
              ? null
              : handleNext),
      Container(width: 14.0),
    ]);

    if (shrinkWrap) {
      return SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Semantics(
              container: true,
              child: DefaultTextStyle(
                // These typographic styles aren't quite the regular ones. We pick the closest ones from the regular
                // list and then tweak them appropriately.
                // See https://material.io/design/components/data-tables.html#tables-within-cards
                style: _selectedRowCount > 0
                    ? themeData.textTheme.subhead
                        .copyWith(color: themeData.accentColor)
                    : themeData.textTheme.title
                        .copyWith(fontWeight: FontWeight.w400),
                child: IconTheme.merge(
                  data: const IconThemeData(opacity: 0.54),
                  child: ButtonTheme.bar(
                    child: Ink(
                      height: 64.0,
                      color: _selectedRowCount > 0
                          ? themeData.secondaryHeaderColor
                          : null,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: startPadding, end: 14.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: headerWidgets),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              dragStartBehavior: dragStartBehavior,
              child: Builder(
                builder: (BuildContext context) {
                  final rows = _getRows(firstRowIndex, rowsPerPage);
                  return DataTable(
                    key: _tableKey,
                    columns: columns,
                    sortColumnIndex: sortColumnIndex,
                    sortAscending: sortAscending,
                    onSelectAll: onSelectAll,
                    rows: rows,
                  );
                },
              ),
            ),
            DefaultTextStyle(
              style: footerTextStyle,
              child: IconTheme.merge(
                data: const IconThemeData(opacity: 0.54),
                child: Container(
                  height: 56.0,
                  child: SingleChildScrollView(
                    dragStartBehavior: dragStartBehavior,
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Row(
                      children: footerWidgets,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // CARD
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Semantics(
            container: true,
            child: DefaultTextStyle(
              // These typographic styles aren't quite the regular ones. We pick the closest ones from the regular
              // list and then tweak them appropriately.
              // See https://material.io/design/components/data-tables.html#tables-within-cards
              style: _selectedRowCount > 0
                  ? themeData.textTheme.subhead
                      .copyWith(color: themeData.accentColor)
                  : themeData.textTheme.title
                      .copyWith(fontWeight: FontWeight.w400),
              child: IconTheme.merge(
                data: const IconThemeData(opacity: 0.54),
                child: ButtonTheme.bar(
                  child: Ink(
                    height: 64.0,
                    color: _selectedRowCount > 0
                        ? themeData.secondaryHeaderColor
                        : null,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                          start: startPadding, end: 14.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: headerWidgets),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 8,
              child: Scrollbar(
                  child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        key: _tableKey,
                        columns: columns,
                        sortColumnIndex: sortColumnIndex,
                        sortAscending: sortAscending,
                        onSelectAll: onSelectAll,
                        rows: _getRows(firstRowIndex, rowsPerPage)),
                  ),
                ],
              ))),
          DefaultTextStyle(
            style: footerTextStyle,
            child: IconTheme.merge(
              data: const IconThemeData(opacity: 0.54),
              child: Container(
                height: 56.0,
                child: SingleChildScrollView(
                  dragStartBehavior: dragStartBehavior,
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Row(
                    children: footerWidgets,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
