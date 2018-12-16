part of native_widgets;

// Native Switch
class NativeSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final bool showMaterial;

  NativeSwitch({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.activeColor,
    this.showMaterial = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool _isIos = showCupertino(showMaterial: showMaterial);

    if (_isIos) {
      return CupertinoSwitch(
        key: key,
        value: value,
        onChanged: onChanged,
        activeColor:
            activeColor == null ? CupertinoColors.activeGreen : activeColor,
      );
    }
    return Switch(
      key: key,
      value: value,
      onChanged: onChanged,
      activeColor: activeColor,
    );
  }
}
