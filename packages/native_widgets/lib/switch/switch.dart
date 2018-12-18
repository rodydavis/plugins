part of native_widgets;

// Native Switch
class NativeSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;

  NativeSwitch({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      key: key,
      ios: (BuildContext context) => CupertinoSwitch(
            key: key,
            value: value,
            onChanged: onChanged,
            activeColor:
                activeColor == null ? CupertinoColors.activeGreen : activeColor,
          ),
      android: (BuildContext context) => Switch(
            key: key,
            value: value,
            onChanged: onChanged,
            activeColor: activeColor,
          ),
    );
  }
}
