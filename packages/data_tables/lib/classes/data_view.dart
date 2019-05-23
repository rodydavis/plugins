import 'package:flutter/material.dart';

abstract class DataTableView {
  List<DataColumn> get columns;
  int get sortColumnIndex;
  bool get sortAscending;
  Function(bool) get onSelectAll;
  List<DataRow> get rows;
}
