import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../persist_theme.dart';

class DarkModeSwitch extends StatelessWidget {
  const DarkModeSwitch({
    this.leading,
    this.subtitle,
    this.title = const Text("Dark Mode"),
  });

  final Widget leading, subtitle, title;

  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<ThemeModel>(
        builder: (context, child, model) => Container(
              child: ListTile(
                leading: leading,
                subtitle: subtitle,
                title: title,
                trailing: Switch.adaptive(
                  value: model.settings.darkMode,
                  onChanged: model.changeDarkMode,
                ),
              ),
            ));
  }
}
