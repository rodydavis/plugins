import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../persist_theme.dart';
import 'picker.dart';

class PrimaryColorPicker extends StatelessWidget {
  const PrimaryColorPicker({
    this.leading,
    this.subtitle,
    this.label = "Primary Color",
    this.title = const Text("Primary Color"),
    this.showOnlyCustomTheme = true,
  });

  final Widget leading, subtitle, title;
  final String label;
  final bool showOnlyCustomTheme;

  @override
  Widget build(BuildContext context) {
    return new Consumer<ThemeModel>(
        builder: (context, model, child) => Container(
              child: !showOnlyCustomTheme ||
                      (model.customTheme &&
                          showOnlyCustomTheme &&
                          !model.darkMode)
                  ? ListTile(
                      leading: leading,
                      subtitle: subtitle,
                      title: title,
                      trailing: Container(
                        width: 100.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                            color: model.primaryColor,
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text(label),
                                content: SingleChildScrollView(
                                  child: CustomColorPicker(
                                    value: model.primaryColor,
                                    onChanged: model.changePrimaryColor,
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
