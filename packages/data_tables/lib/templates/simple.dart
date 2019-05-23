import 'package:flutter/material.dart';

class SimpleDataTable extends StatelessWidget implements DataTable {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  List<DataColumn> get columns => null;

  @override
  get onSelectAll => null;

  @override
  List<DataRow> get rows => null;

  @override
  bool get sortAscending => null;

  @override
  int get sortColumnIndex => null;
}
