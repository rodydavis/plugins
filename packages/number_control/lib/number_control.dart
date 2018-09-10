library number_control;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NumberControl extends StatefulWidget {
  const NumberControl({
    @required this.value,
    @required this.onChanged,
    this.min,
    this.max,
  });
  final ValueChanged<int> onChanged;
  final int value, max, min;

  @override
  _NumberControlState createState() => _NumberControlState();
}

class _NumberControlState extends State<NumberControl> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: 100.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            circleIconButton(
                icon: FontAwesomeIcons.minus,
                onPressed: widget.value == widget.min
                    ? null
                    : () => setState(() => widget.onChanged(widget.value - 1))),
            circleIconButton(
                icon: FontAwesomeIcons.plus,
                onPressed: widget.value == widget.max
                    ? null
                    : () => setState(() => widget.onChanged(widget.value + 1))),
          ],
        ),
      ),
    );
  }
}

Widget circleIconButton({@required IconData icon, VoidCallback onPressed}) {
  return Container(
    decoration: ShapeDecoration(
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
