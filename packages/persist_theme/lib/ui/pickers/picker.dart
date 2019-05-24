import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class CustomColorPicker extends StatefulWidget {
  const CustomColorPicker({
    this.onChanged,
    @required this.value,
  });

  final ValueChanged<Color> onChanged;
  final Color value;

  @override
  _CustomColorPickerState createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  Color main;

  @override
  void initState() {
    main = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialColorPicker(
      selectedColor: main,
      onMainColorChange: (ColorSwatch color) {
        if (mounted)
          setState(() {
            main = color;
          });
      },
      onColorChange: (color) => widget.onChanged(color),
    );
  }
}
