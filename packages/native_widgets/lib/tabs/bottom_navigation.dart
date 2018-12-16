part of native_widgets;

// Native Tab Bar
class NativeBottomTabBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final ValueChanged<int> onTap;
  final Color activeColor;
  final double iconSize;
  final int currentIndex;

  NativeBottomTabBar(
      {Key key,
      @required this.items,
      this.onTap,
      this.activeColor,
      this.currentIndex,
      this.iconSize});

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS
        ? CupertinoTabBar(
            key: key,
            items: items,
            onTap: onTap,
            currentIndex: currentIndex == null ? 0 : currentIndex,
            activeColor:
                activeColor == null ? CupertinoColors.activeBlue : activeColor,
            backgroundColor: Colors.transparent,
            iconSize: iconSize == null ? 30.0 : iconSize,
          )
        : BottomNavigationBar(
            key: key,
            type: BottomNavigationBarType.fixed,
            onTap: onTap,
            currentIndex: currentIndex == null ? 0 : currentIndex,
            fixedColor: activeColor,
            items: items,
            iconSize: iconSize == null ? 30.0 : iconSize,
          ));
  }
}
