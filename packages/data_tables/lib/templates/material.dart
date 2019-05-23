import 'package:flutter/material.dart';

class MaterialDataTable extends DataTable {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: columns,
      rows: rows,
      onSelectAll: onSelectAll,
      sortAscending: sortAscending,
      sortColumnIndex: sortColumnIndex,
    );
  }
}
