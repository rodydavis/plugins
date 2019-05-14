[![Buy Me A Coffee](https://img.shields.io/badge/Donate-Buy%20Me%20A%20Coffee-yellow.svg)](https://www.buymeacoffee.com/rodydavis)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=WSH3GVC49GNNJ)

# data_tables

* Full Screen Pagnitated Data Tables for Tablets/Desktops
* Mobile ListView with Action Buttons for Sorting and Selecting All
* Supports Dark Mode

## Getting Started

* You can optionally build the listview for mobile with a builder, by default it creates a ExpansionTile with the remaining columns as children
* The tablet breakpoint can also be set.

   `bool showMobileListView;` - When set to false it will always show a data table

   `int sortColumnIndex;` - Current Sorted Column

   `bool sortAscending;` - Sort Order

   `ValueChanged<bool> onSelectAll;` - Called for Selecting and Deselecting All

   `ValueChanged<int> onRowsPerPageChanged;` - Called when rows change on data table or last row reached on mobile.

   `int rowsPerPage;` - Default Rows per page

   `Widget header;` - Widget header for Desktop and Tablet Data Table

   `List<DataColumn> columns;` - List of Columns (Must match length of DataCells in DataSource)

   `IndexedWidgetBuilder mobileItemBuilder;` - Optional Item builder for the list view for Mobile

   `Size tabletBreakpoint;` - Tablet breakpoint for the screen width and height

   `List<Widget> actions, selectedActions;` - Actions that show when items are selected or not

   `RefreshCallback onRefresh;` - If not null the list view will be wrapped in a RefreshIndicator

## Screenshots

![](https://github.com/AppleEducate/plugins/blob/master/packages/data_tables/screenshots/1.PNG)

![](https://github.com/AppleEducate/plugins/blob/master/packages/data_tables/screenshots/2.PNG)

![](https://github.com/AppleEducate/plugins/blob/master/packages/data_tables/screenshots/3.PNG)

![](https://github.com/AppleEducate/plugins/blob/master/packages/data_tables/screenshots/4.PNG)

![](https://github.com/AppleEducate/plugins/blob/master/packages/data_tables/screenshots/5.PNG)


## Example

``` dart
import 'package:data_tables/data_tables.dart';
import 'package:flutter/material.dart';

import 'data/dessert.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  void initState() {
    _items = _desserts;
    super.initState();
  }

  void _sort<T>(
      Comparable<T> getField(Dessert d), int columnIndex, bool ascending) {
    _items.sort((Dessert a, Dessert b) {
      if (!ascending) {
        final Dessert c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  List<Dessert> _items = [];
  int _rowsOffset = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Data Table Example'),
        ),
        body: NativeDataTable.builder(
          rowsPerPage: _rowsPerPage,
          itemCount: _items?.length ?? 0,
          firstRowIndex: _rowsOffset,
          handleNext: () async {
            setState(() {
              _rowsOffset += _rowsPerPage;
            });

            await new Future.delayed(new Duration(seconds: 3));
            setState(() {
              _items += [
                Dessert('New Item 4', 159, 6.0, 24, 4.0, 87, 14, 1),
                Dessert('New Item 5', 159, 6.0, 24, 4.0, 87, 14, 1),
                Dessert('New Item 6', 159, 6.0, 24, 4.0, 87, 14, 1),
              ];
            });
          },
          handlePrevious: () {
            setState(() {
              _rowsOffset -= _rowsPerPage;
            });
          },
          itemBuilder: (int index) {
            final Dessert dessert = _items[index];
            return DataRow.byIndex(
                index: index,
                selected: dessert.selected,
                onSelectChanged: (bool value) {
                  if (dessert.selected != value) {
                    setState(() {
                      dessert.selected = value;
                    });
                  }
                },
                cells: <DataCell>[
                  DataCell(Text('${dessert.name}')),
                  DataCell(Text('${dessert.calories}')),
                  DataCell(Text('${dessert.fat.toStringAsFixed(1)}')),
                  DataCell(Text('${dessert.carbs}')),
                  DataCell(Text('${dessert.protein.toStringAsFixed(1)}')),
                  DataCell(Text('${dessert.sodium}')),
                  DataCell(Text('${dessert.calcium}%')),
                  DataCell(Text('${dessert.iron}%')),
                ]);
          },
          header: const Text('Data Management'),
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          onRefresh: () async {
            await new Future.delayed(new Duration(seconds: 3));
            setState(() {
              _items = _desserts;
            });
            return null;
          },
          onRowsPerPageChanged: (int value) {
            setState(() {
              _rowsPerPage = value;
            });
            print("New Rows: $value");
          },
          // mobileItemBuilder: (BuildContext context, int index) {
          //   final i = _desserts[index];
          //   return ListTile(
          //     title: Text(i?.name),
          //   );
          // },
          onSelectAll: (bool value) {
            for (var row in _items) {
              setState(() {
                row.selected = value;
              });
            }
          },
          rowCountApproximate: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {},
            ),
          ],
          selectedActions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  for (var item in _items
                      ?.where((d) => d?.selected ?? false)
                      ?.toSet()
                      ?.toList()) {
                    _items.remove(item);
                  }
                });
              },
            ),
          ],
          columns: <DataColumn>[
            DataColumn(
                label: const Text('Dessert (100g serving)'),
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Dessert d) => d.name, columnIndex, ascending)),
            DataColumn(
                label: const Text('Calories'),
                tooltip:
                    'The total amount of food energy in the given serving size.',
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<num>(
                    (Dessert d) => d.calories, columnIndex, ascending)),
            DataColumn(
                label: const Text('Fat (g)'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((Dessert d) => d.fat, columnIndex, ascending)),
            DataColumn(
                label: const Text('Carbs (g)'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((Dessert d) => d.carbs, columnIndex, ascending)),
            DataColumn(
                label: const Text('Protein (g)'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<num>(
                    (Dessert d) => d.protein, columnIndex, ascending)),
            DataColumn(
                label: const Text('Sodium (mg)'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<num>(
                    (Dessert d) => d.sodium, columnIndex, ascending)),
            DataColumn(
                label: const Text('Calcium (%)'),
                tooltip:
                    'The amount of calcium as a percentage of the recommended daily amount.',
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<num>(
                    (Dessert d) => d.calcium, columnIndex, ascending)),
            DataColumn(
                label: const Text('Iron (%)'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((Dessert d) => d.iron, columnIndex, ascending)),
          ],
        ),
      ),
    );
  }

  final List<Dessert> _desserts = <Dessert>[
    Dessert('Frozen yogurt', 159, 6.0, 24, 4.0, 87, 14, 1),
    Dessert('Ice cream sandwich', 237, 9.0, 37, 4.3, 129, 8, 1),
    Dessert('Eclair', 262, 16.0, 24, 6.0, 337, 6, 7),
    Dessert('Cupcake', 305, 3.7, 67, 4.3, 413, 3, 8),
    Dessert('Gingerbread', 356, 16.0, 49, 3.9, 327, 7, 16),
    Dessert('Jelly bean', 375, 0.0, 94, 0.0, 50, 0, 0),
    Dessert('Lollipop', 392, 0.2, 98, 0.0, 38, 0, 2),
    Dessert('Honeycomb', 408, 3.2, 87, 6.5, 562, 0, 45),
    Dessert('Donut', 452, 25.0, 51, 4.9, 326, 2, 22),
    Dessert('KitKat', 518, 26.0, 65, 7.0, 54, 12, 6),
    Dessert('Frozen yogurt with sugar', 168, 6.0, 26, 4.0, 87, 14, 1),
    Dessert('Ice cream sandwich with sugar', 246, 9.0, 39, 4.3, 129, 8, 1),
    Dessert('Eclair with sugar', 271, 16.0, 26, 6.0, 337, 6, 7),
    Dessert('Cupcake with sugar', 314, 3.7, 69, 4.3, 413, 3, 8),
    Dessert('Gingerbread with sugar', 345, 16.0, 51, 3.9, 327, 7, 16),
    Dessert('Jelly bean with sugar', 364, 0.0, 96, 0.0, 50, 0, 0),
    Dessert('Lollipop with sugar', 401, 0.2, 100, 0.0, 38, 0, 2),
    Dessert('Honeycomb with sugar', 417, 3.2, 89, 6.5, 562, 0, 45),
    Dessert('Donut with sugar', 461, 25.0, 53, 4.9, 326, 2, 22),
    Dessert('KitKat with sugar', 527, 26.0, 67, 7.0, 54, 12, 6),
    Dessert('Frozen yogurt with honey', 223, 6.0, 36, 4.0, 87, 14, 1),
    Dessert('Ice cream sandwich with honey', 301, 9.0, 49, 4.3, 129, 8, 1),
    Dessert('Eclair with honey', 326, 16.0, 36, 6.0, 337, 6, 7),
    Dessert('Cupcake with honey', 369, 3.7, 79, 4.3, 413, 3, 8),
    Dessert('Gingerbread with honey', 420, 16.0, 61, 3.9, 327, 7, 16),
    Dessert('Jelly bean with honey', 439, 0.0, 106, 0.0, 50, 0, 0),
    Dessert('Lollipop with honey', 456, 0.2, 110, 0.0, 38, 0, 2),
    Dessert('Honeycomb with honey', 472, 3.2, 99, 6.5, 562, 0, 45),
    Dessert('Donut with honey', 516, 25.0, 63, 4.9, 326, 2, 22),
    Dessert('KitKat with honey', 582, 26.0, 77, 7.0, 54, 12, 6),
    Dessert('Frozen yogurt with milk', 262, 8.4, 36, 12.0, 194, 44, 1),
    Dessert('Ice cream sandwich with milk', 339, 11.4, 49, 12.3, 236, 38, 1),
    Dessert('Eclair with milk', 365, 18.4, 36, 14.0, 444, 36, 7),
    Dessert('Cupcake with milk', 408, 6.1, 79, 12.3, 520, 33, 8),
    Dessert('Gingerbread with milk', 459, 18.4, 61, 11.9, 434, 37, 16),
    Dessert('Jelly bean with milk', 478, 2.4, 106, 8.0, 157, 30, 0),
    Dessert('Lollipop with milk', 495, 2.6, 110, 8.0, 145, 30, 2),
    Dessert('Honeycomb with milk', 511, 5.6, 99, 14.5, 669, 30, 45),
    Dessert('Donut with milk', 555, 27.4, 63, 12.9, 433, 32, 22),
    Dessert('KitKat with milk', 621, 28.4, 77, 15.0, 161, 42, 6),
    Dessert('Coconut slice and frozen yogurt', 318, 21.0, 31, 5.5, 96, 14, 7),
    Dessert(
        'Coconut slice and ice cream sandwich', 396, 24.0, 44, 5.8, 138, 8, 7),
    Dessert('Coconut slice and eclair', 421, 31.0, 31, 7.5, 346, 6, 13),
    Dessert('Coconut slice and cupcake', 464, 18.7, 74, 5.8, 422, 3, 14),
    Dessert('Coconut slice and gingerbread', 515, 31.0, 56, 5.4, 316, 7, 22),
    Dessert('Coconut slice and jelly bean', 534, 15.0, 101, 1.5, 59, 0, 6),
    Dessert('Coconut slice and lollipop', 551, 15.2, 105, 1.5, 47, 0, 8),
    Dessert('Coconut slice and honeycomb', 567, 18.2, 94, 8.0, 571, 0, 51),
    Dessert('Coconut slice and donut', 611, 40.0, 58, 6.4, 335, 2, 28),
    Dessert('Coconut slice and KitKat', 677, 41.0, 72, 8.5, 63, 12, 12),
  ];
}

```