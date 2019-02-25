import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../persist_theme.dart';

class CustomThemeSwitch extends StatelessWidget {
  const CustomThemeSwitch({
    this.leading,
    this.subtitle,
    this.title = const Text("Custom Theme"),
    this.showOnlyLightMode = true,
  });

  final Widget leading, subtitle, title;
  final bool showOnlyLightMode;

  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<ThemeModel>(
        builder: (context, child, model) => Container(
              child: !showOnlyLightMode ||
                      !model.settings.darkMode && showOnlyLightMode
                  ? ListTile(
                      leading: leading,
                      subtitle: subtitle,
                      title: title,
                      trailing: Switch.adaptive(
                        value: model.settings.customTheme,
                        onChanged: model.changeCustomTheme,
                      ),
                    )
                  : null,
            ));
  }
}
