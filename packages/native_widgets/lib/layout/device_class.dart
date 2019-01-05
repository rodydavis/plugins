part of native_widgets;

class NativeLayout extends StatelessWidget {
  final Widget mobile, tablet, desktop;

  final double tabletBreakpoint, desktopBreakpoint;

  final bool alwaysShowMobile;

  const NativeLayout({
    @required this.mobile,
    this.tablet,
    this.desktop,
    this.tabletBreakpoint = 480.0,
    this.desktopBreakpoint = 1024.0,
    this.alwaysShowMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    if (alwaysShowMobile == false) {
      if (_width == desktopBreakpoint) {
        return desktop ?? tablet ?? mobile;
      }
      if (_width == tabletBreakpoint) {
        return tablet ?? mobile;
      }
    }
    return mobile;
  }
}
