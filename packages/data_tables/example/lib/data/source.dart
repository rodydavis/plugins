import 'package:flutter/material.dart';

import 'dessert.dart';

class DessertDataSource extends DataTableSource {
  DessertDataSource({
    @required this.items,
  });

  List<Dessert> items;

  void sort<T>(Comparable<T> getField(Dessert d), bool ascending) {
    items.sort((Dessert a, Dessert b) {
      if (!ascending) {
        final Dessert c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= items.length) return null;
    final Dessert dessert = items[index];
    return DataRow.byIndex(
        index: index,
        selected: dessert.selected,
        onSelectChanged: (bool value) {
          if (dessert.selected != value) {
            _selectedCount += value ? 1 : -1;
            assert(_selectedCount >= 0);
            dessert.selected = value;
            notifyListeners();
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
  }

  @override
  int get rowCount => items.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void selectAll(bool checked) {
    for (Dessert dessert in items) dessert.selected = checked;
    _selectedCount = checked ? items.length : 0;
    notifyListeners();
  }
}
