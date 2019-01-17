part of native_widgets;

class NativeTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final CupertinoNativeTextButtonData ios;
  final MaterialNativeTextButtonData android;
  final TextStyle style;

  NativeTextButton({
    Key key,
    this.onPressed,
    @required this.label,
    this.ios,
    this.android,
    this.style = const TextStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      key: key,
      ios: (BuildContext context) {
        if (onPressed == null) {
          return Text(
            label,
            style: style.copyWith(color: CupertinoColors.inactiveGray),
          );
        }

        return GestureDetector(
          onTap: onPressed,
          child: Text(
            label,
            style: style.copyWith(
              color: ios?.activeColor ?? CupertinoColors.activeBlue,
            ),
          ),
        );
      },
      android: (BuildContext context) {
        return InkWell(
          onTap: onPressed,
          child: Text(label,
              style: style.copyWith(
                color: onPressed == null ? Colors.grey : android?.activeColor,
              )),
        );
      },
    );
  }
}

class CupertinoNativeTextButtonData {
  final Color activeColor;

  CupertinoNativeTextButtonData({
    this.activeColor = CupertinoColors.activeBlue,
  });
}

class MaterialNativeTextButtonData {
  final Color activeColor;

  MaterialNativeTextButtonData({
    this.activeColor = Colors.blue,
  });
}
