library number_control;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NumberControl extends StatefulWidget {

  NumberControl({
    @required this.onChanged,
    this.min,
    this.max,
    this.defaultValue,
  });
  final int max, min, defaultValue;
  final ValueChanged<int> onChanged;

  @override
  _NumberControlState createState() => _NumberControlState();
}

class _NumberControlState extends State<NumberControl> {
  int _value;
  @override
  void initState() {
    _value = widget.defaultValue ?? 0;
    super.initState();
  }

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
                onPressed: _value == widget.min
                    ? null
                    : () {
                        setState(() {
                          _value -= 1;
                          widget.onChanged(_value);
                        });
                      }),
            circleIconButton(
                icon: FontAwesomeIcons.plus,
                onPressed: _value == widget.max
                    ? null
                    : () {
                        setState(() {
                          _value += 1;
                          widget.onChanged(_value);
                        });
                      }),
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
