import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_colorpicker/material_picker.dart';

enum PickerType { normal, material, block }

class CustomColorPicker extends StatelessWidget {
  const CustomColorPicker({
    this.type = PickerType.normal,
    this.onChanged,
    @required this.value,
  });

  final PickerType type;
  final ValueChanged<Color> onChanged;
  final Color value;

  @override
  Widget build(BuildContext context) {
    if (type == PickerType.block) {
      return BlockPicker(
        pickerColor: value,
        onColorChanged: onChanged,
      );
    }
    if (type == PickerType.material) {
      return MaterialPicker(
        pickerColor: value,
        onColorChanged: onChanged,
        enableLabel: true, // only on portrait mode
      );
    }
    return ColorPicker(
      pickerColor: value,
      onColorChanged: onChanged,
      enableLabel: true,
      pickerAreaHeightPercent: 0.8,
    );
  }
}
