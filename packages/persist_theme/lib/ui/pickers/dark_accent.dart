import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../persist_theme.dart';
import 'picker.dart';

class DarkAccentColorPicker extends StatelessWidget {
  const DarkAccentColorPicker({
    this.leading,
    this.subtitle,
    this.label = "Accent Color",
    this.title = const Text("Accent Color"),
    this.showOnlyDarkMode = true,
  });

  final Widget leading, subtitle, title;
  final String label;
  final bool showOnlyDarkMode;

  @override
  Widget build(BuildContext context) {
    return new Consumer<ThemeModel>(
        builder: (context, model, child) => Container(
              child: !showOnlyDarkMode || model.darkMode && showOnlyDarkMode
                  ? ListTile(
                      leading: leading,
                      subtitle: subtitle,
                      title: title,
                      trailing: Container(
                        width: 100.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                            color: model.darkAccentColor,
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text(label),
                                content: SingleChildScrollView(
                                  child: CustomColorPicker(
                                    value: model.darkAccentColor,
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
