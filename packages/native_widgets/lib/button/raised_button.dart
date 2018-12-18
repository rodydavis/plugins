part of native_widgets;

// Native Button
class NativeButton extends StatelessWidget {
  final Key widgetKey;
  final Widget child;
  final VoidCallback onPressed;
  final Color color, disabledColor;
  final EdgeInsetsGeometry padding;
  final CupertinoButtonData ios;
  final MaterialRaisedButtonData android;

  NativeButton({
    Key key,
    this.widgetKey,
    this.child,
    this.onPressed,
    this.padding,
    this.color,
    this.disabledColor,
    this.ios,
    this.android,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformButton(
      key: key,
      widgetKey: widgetKey,
      child: child,
      padding: padding,
      color: color,
      disabledColor: disabledColor,
      onPressed: onPressed,
      ios: (BuildContext context) => ios,
      android: (BuildContext context) => android,
    );
  }
}
