import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/models/theme_model.dart';

export 'data/models/theme_model.dart';
export 'ui/theme_widgets.dart';

class PersistTheme extends StatefulWidget {
  final ThemeModel model;
  final Widget Function(BuildContext, ThemeModel) builder;

  const PersistTheme({
    Key key,
    @required this.model,
    @required this.builder,
  }) : super(key: key);

  @override
  _PersistThemeState createState() => _PersistThemeState();
}

class _PersistThemeState extends State<PersistTheme>
    {
  ThemeModel _themeModel;
  void _init() async {
    try {
      _themeModel = widget.model..init();
    } catch (e) {}
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void didUpdateWidget(PersistTheme oldWidget) {
    if (oldWidget.model != widget.model) {
      _init();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<ThemeModel>(
      builder: (_) => _themeModel,
      child: Consumer<ThemeModel>(
        builder: (context, model, child) => widget.builder(context, model),
      ),
    );
  }
}
