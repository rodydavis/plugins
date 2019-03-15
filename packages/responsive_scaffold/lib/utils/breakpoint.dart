import 'package:flutter/material.dart';

bool isTablet(BuildContext context, {@required Size breakpoint}) {
  final Size _size = MediaQuery.of(context).size;
  return _size.width >= breakpoint.width && _size.height >= breakpoint.height;
}
