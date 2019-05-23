import 'package:flutter/material.dart';

class WorksheetDataTable extends StatelessWidget {
  WorksheetDataTable({
    @required this.columns,
    @required this.rows,
    this.sortColumnIndex,
    this.sortAscending,
    this.onSelectAll,
    this.rowHeight = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    // TableCell()
    // DataCell(child)
    return Table(
      columnWidths: {
        0: FlexColumnWidth(0.1),
      },
      border: TableBorder.all(width: 1.0, color: Colors.black),
      children: [
        TableRow(
          children: [
            Container(
              height: rowHeight,
              child: Center(
                child: Icon(Icons.info_outline),
              ),
            ),
            for (var column in columns) ...[
              Container(
                height: rowHeight,
                color: Colors.grey[200],
                child: Center(
                  child: Text(
                    '${getColumnLetter(columns.indexOf(column))}'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        for (var row in rows) ...[
          TableRow(
            children: [
              Container(
                height: rowHeight,
                color: Colors.grey[200],
                child: Center(
                  child: Text(
                    '${rows.indexOf(row) + 1}',
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              for (Cell<String> cell in row.cells) ...[
                Container(
                  height: rowHeight,
                  child: TextFormField(
                    initialValue: cell.value,
                    onSaved: cell.onChanged,
                  ),
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }

  final List<Widget> columns;
  final Function(bool) onSelectAll;
  final List<CellRow> rows;
  final bool sortAscending;
  final int sortColumnIndex;
  final double rowHeight;

  String getColumnLetter(int index) {
    if (index < _letters.length) {
      return _letters[index];
    }
    return '';
  }
}

const _letters = [
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'i',
  'j',
  'k',
  'l',
  'm',
  'n',
  'o',
  'p',
  'q',
  'r',
  's',
  't',
  'u',
  'v',
  'w',
  'x',
  'y',
  'z'
];

class CellRow {
  const CellRow({
    @required this.cells,
  });
  final List<Cell<String>> cells;
}

class Cell<T> {
  const Cell({
    this.onChanged,
    this.value,
  });
  final ValueChanged<T> onChanged;
  final T value;
}

// class CellFormField<T> extends FormField<T> {
//   CellFormField({
//     FormFieldSetter<T> onSaved,
//     FormFieldValidator<T> validator,
//     T initialValue,
//     bool autovalidate = false,
//   }) : super(
//             onSaved: onSaved,
//             validator: validator,
//             initialValue: initialValue,
//             autovalidate: autovalidate,
//             builder: (FormFieldState<T> state) {
//               return TextFormField();
//             });
// }
