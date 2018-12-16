part of native_widgets;

// Native Button
class NativeButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color buttonColor;
  final EdgeInsetsGeometry paddingExternal;
  final EdgeInsetsGeometry paddingInternal;
  final double minWidthAndroid;
  final double minSizeiOS;
  final double heightAndroid;
  final Color splashColorAndroid;

  NativeButton(
      {this.child,
      this.onPressed,
      this.paddingExternal,
      this.paddingInternal,
      this.buttonColor,
      this.minWidthAndroid,
      this.splashColorAndroid,
      this.heightAndroid,
      this.minSizeiOS});

  @override
  Widget build(BuildContext context) {
    return (Padding(
      padding:
          paddingExternal == null ? const EdgeInsets.all(0.0) : paddingExternal,
      child: Platform.isIOS
          ? CupertinoButton(
              padding: paddingInternal,
              minSize: minSizeiOS,
              color: buttonColor,
              child: child,
              onPressed: Feedback.wrapForTap(onPressed, context),
            )
          : MaterialButton(
              minWidth: minWidthAndroid,
              height: heightAndroid,
              color: buttonColor,
              splashColor: splashColorAndroid,
              padding: paddingInternal,
              child: child,
              onPressed: Feedback.wrapForTap(onPressed, context),
            ),
    ));
  }
}