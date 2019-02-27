import 'package:flutter/material.dart';

import 'dessert.dart';

class DessertDataSource extends DataTableSource {
  List<Dessert> _items = [];

  void sort<T>(Comparable<T> getField(Dessert d), bool ascending) {
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
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _items.length) return null;
    final Dessert dessert = _items[index];
    return DataRow.byIndex(
        index: index,
        selected: dessert.selected,
        onSelectChanged: (bool value) {
          if (dessert.selected != value) {
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
  int get rowCount => _items.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selected?.length ?? 0;

  void selectAll(bool checked) {
    for (Dessert dessert in _items) dessert.selected = checked;
    notifyListeners();
  }

  void removeItem(Dessert desert) {
    _items.remove(desert);
    notifyListeners();
  }

  List<Dessert> get selected =>
      _items?.where((d) => d.selected)?.toList() ?? [];

  void initItems(List<Dessert> data) {
    _items = data;
    notifyListeners();
  }
}
