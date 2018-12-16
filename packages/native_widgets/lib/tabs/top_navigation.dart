part of native_widgets;

class NativeTopTabs extends StatelessWidget {
  final bool showMaterial;

  NativeTopTabs({
    this.showMaterial = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool _isIos = showCupertino(showMaterial: showMaterial);
    return Container();
  }
}
