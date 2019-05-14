import 'package:flutter/material.dart';

int getCrossAxisCount(BuildContext context, {double itemWidth = 250.0}) {
  final _size = MediaQuery.of(context).size;
  var _count = (_size.width / itemWidth).round();
  // updateLog("Size: $_size, Count: $_count");
  return _count;
}
