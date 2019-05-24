import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return new Consumer<ThemeModel>(
        builder: (context, model, child) => Container(
              child: !showOnlyLightMode || !model.darkMode && showOnlyLightMode
                  ? ListTile(
                      leading: leading,
                      subtitle: subtitle,
                      title: title,
                      trailing: Switch.adaptive(
                        value: model.customTheme,
                        onChanged: model.changeCustomTheme,
                      ),
                    )
                  : null,
            ));
  }
}
