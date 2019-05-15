import 'package:flutter/material.dart';

int getCrossAxisCount(BuildContext context, {double itemWidth = 250.0}) {
  final _size = MediaQuery.of(context).size;
  var _count = (_size.width / itemWidth).round();
  if (_count <= 0) return 1;
  return _count;
}
