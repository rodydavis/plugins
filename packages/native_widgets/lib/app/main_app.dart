part of native_widgets;

class NativeApp extends StatelessWidget {
  final bool showMaterial;
  final Color appBackground;
  final Widget home;

  NativeApp({
    this.showMaterial = false,
    this.appBackground,
    this.home,
  });

  @override
  Widget build(BuildContext context) {
    final bool _isIos = showCupertino(showMaterial: showMaterial);
    if (_isIos) {
      return CupertinoApp(
        color: appBackground,
        home: home,
      );
    }
    return MaterialApp(
      color: appBackground,
      home: home,
    );
  }
}
