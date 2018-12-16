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
  final bool showMaterial;

  NativeButton({
    this.child,
    this.onPressed,
    this.paddingExternal,
    this.paddingInternal,
    this.buttonColor,
    this.minWidthAndroid,
    this.splashColorAndroid,
    this.heightAndroid,
    this.minSizeiOS,
    this.showMaterial = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool _isIos = showCupertino(showMaterial: showMaterial);

    if (_isIos) {
      return Container(
        padding: paddingExternal == null
            ? const EdgeInsets.all(0.0)
            : paddingExternal,
        child: CupertinoButton(
          padding: paddingInternal,
          minSize: minSizeiOS,
          color: buttonColor,
          child: child,
          onPressed: Feedback.wrapForTap(onPressed, context),
        ),
      );
    }
    return Container(
      padding:
          paddingExternal == null ? const EdgeInsets.all(0.0) : paddingExternal,
      child: MaterialButton(
        minWidth: minWidthAndroid,
        height: heightAndroid,
        color: buttonColor,
        splashColor: splashColorAndroid,
        padding: paddingInternal,
        child: child,
        onPressed: Feedback.wrapForTap(onPressed, context),
      ),
    );
  }
}
