import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../persist_theme.dart';
import 'picker.dart';

class DarkAccentColorPicker extends StatelessWidget {
  const DarkAccentColorPicker({
    this.leading,
    this.subtitle,
    this.type = PickerType.normal,
    this.label = "Accent Color",
    this.title = const Text("Accent Color"),
    this.showOnlyDarkMode = true,
  });

  final Widget leading, subtitle, title;
  final PickerType type;
  final String label;
  final bool showOnlyDarkMode;

  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<ThemeModel>(
        builder: (context, child, model) => Container(
              child: !showOnlyDarkMode ||
                      model.settings.darkMode && showOnlyDarkMode
                  ? ListTile(
                      leading: leading,
                      subtitle: subtitle,
                      title: title,
                      trailing: Container(
                        width: 100.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                            color: model.settings.darkAccentColor,
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text(label),
                                content: SingleChildScrollView(
                                  child: CustomColorPicker(
                                    type: type,
                                    value: model.settings.darkAccentColor,
                                    onChanged: model.changeDarkAccentColor,
                                  ),
                                ),
                              ),
                        );
                      },
                    )
                  : null,
            ));
  }
}
