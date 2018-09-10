library number_control;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'widgets/circle_icon.dart';

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
    return ButtonBar(
      mainAxisSize: MainAxisSize.min,
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
    );
  }
}
