import 'package:data_tables/data_tables.dart';
import 'package:flutter/material.dart';

class WorksheetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Worksheet Example'),
      ),
      body: WorksheetDataTable(
        columns: <Widget>[
          Text('A'),
          Text('B'),
          Text('C'),
          Text('D'),
        ],
        rows: [
          CellRow(
            cells: [
              Cell<String>(
                value: 'Test A 1',
                onChanged: (val) {},
              ),
              Cell<String>(
                value: 'Test A 2',
                onChanged: (val) {},
              ),
              Cell<String>(
                value: 'Test A 2',
                onChanged: (val) {},
              ),
              Cell<String>(
                value: 'Test A 4',
                onChanged: (val) {},
              ),
            ],
          ),
          CellRow(
            cells: [
              Cell<String>(
                value: 'Test B 1',
                onChanged: (val) {},
              ),
              Cell<String>(
                value: 'Test B 2',
                onChanged: (val) {},
              ),
              Cell<String>(
                value: 'Test B 2',
                onChanged: (val) {},
              ),
              Cell<String>(
                value: 'Test B 4',
                onChanged: (val) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
