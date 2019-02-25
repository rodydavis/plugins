import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../persist_theme.dart';
import 'picker.dart';

class AccentColorPicker extends StatelessWidget {
  const AccentColorPicker({
    this.leading,
    this.type = PickerType.normal,
    this.label = "Accent Color",
    this.subtitle,
    this.title = const Text("Accent Color"),
    this.showOnlyCustomTheme = true,
    this.showOnlyLightMode = true,
  });

  final Widget leading, subtitle, title;
  final PickerType type;
  final String label;
  final bool showOnlyCustomTheme;
  final bool showOnlyLightMode;

  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<ThemeModel>(
        builder: (context, child, model) => Container(
              child: !showOnlyCustomTheme && !showOnlyLightMode ||
                      (model.settings.customTheme && showOnlyCustomTheme) &&
                          (!model.settings.darkMode && showOnlyLightMode)
                  ? ListTile(
                      leading: leading,
                      subtitle: subtitle,
                      title: title,
                      trailing: Container(
                        width: 100.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                            color: model.settings.accentColor,
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
                                    value: model.settings.accentColor,
                                    onChanged: model.changeAccentColor,
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
