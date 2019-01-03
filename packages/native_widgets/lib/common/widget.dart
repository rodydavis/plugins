part of native_widgets;

class NativeWidget extends StatelessWidget {
  final Widget android, ios, windows, fuchsia, macos, linux, child;
  const NativeWidget({
    Key key,
    this.android,
    this.ios,
    this.linux,
    this.fuchsia,
    this.macos,
    this.windows,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _child = Container(key: key, child: child);
    if (Platform.isWindows) {
      return windows ?? _child;
    } else if (Platform.isFuchsia) {
      return fuchsia ?? _child;
    } else if (Platform.isMacOS) {
      return macos ?? _child;
    } else if (Platform.isLinux) {
      return linux ?? _child;
    } else if (Platform.isAndroid) {
      return android ?? _child;
    } else if (Platform.isIOS) {
      return ios ?? _child;
    }
    return _child;
  }
}
