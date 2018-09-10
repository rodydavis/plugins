import 'package:flutter/material.dart';

Widget circleIconButton({@required IconData icon, VoidCallback onPressed}) {
  return Container(
    decoration: const ShapeDecoration(
      shape: CircleBorder(),
      color: Colors.blue,
    ),
    child: IconButton(
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      onPressed: onPressed,
    ),
  );
}
