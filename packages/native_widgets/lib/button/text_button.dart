part of native_widgets;

class NativeTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final CupertinoNativeTextButtonData ios;

  NativeTextButton({
    Key key,
    this.onPressed,
    @required this.label,
    this.ios,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      key: key,
      ios: (BuildContext context) {
        if (onPressed == null) {
          return Text(
            label,
            style: TextStyle(color: ios?.activeColor),
          );
        }

        return GestureDetector(
          onTap: onPressed,
          child: Text(
            label,
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
        );
      },
      android: (BuildContext context) {
        return InkWell(
          onTap: onPressed,
          child: Text(label),
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
