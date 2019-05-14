import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../persist_theme.dart';

class TrueBlackSwitch extends StatelessWidget {
  const TrueBlackSwitch({
    this.leading,
    this.subtitle,
    this.title = const Text("True Black"),
    this.showOnlyDarkMode = true,
  });

  final Widget leading, subtitle, title;
  final bool showOnlyDarkMode;

  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<ThemeModel>(
        builder: (context, child, model) => Container(
              child: !showOnlyDarkMode || model.darkMode && showOnlyDarkMode
                  ? ListTile(
                      leading: leading,
                      subtitle: subtitle,
                      title: title,
                      trailing: Switch.adaptive(
                        value: model.trueBlack,
                        onChanged: model.changeTrueBlack,
                      ),
                    )
                  : null,
            ));
  }
}
