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
    if (Platform.isWindows) {
      return Container(key: key, child: windows ?? child);
    } else if (Platform.isFuchsia) {
      return Container(key: key, child: fuchsia ?? child);
    } else if (Platform.isMacOS) {
      return Container(key: key, child: macos ?? child);
    } else if (Platform.isLinux) {
      return Container(key: key, child: linux ?? child);
    } else if (Platform.isAndroid) {
      return Container(key: key, child: android ?? child);
    } else if (Platform.isIOS) {
      return Container(key: key, child: ios ?? child);
    }
    return Container(key: key, child: child);
  }
}
