part of native_widgets;

class NativeSearchAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final bool isSearching;
  final bool alwaysShowSearchBar;
  final String search;
  final Widget leading, title;
  final List<Widget> actions;
  final ValueChanged<String> onChanged;
  final VoidCallback onSearchPressed;
  final MaterialAppBarData android;
  final CupertinoNavigationBarData ios;
  final Color backgroundColor;

  NativeSearchAppBar({
    this.isSearching = false,
    this.onChanged,
    this.ios,
    this.android,
    this.onSearchPressed,
    this.search,
    this.leading,
    this.title,
    this.actions,
    this.backgroundColor,
    this.alwaysShowSearchBar = false,
    this.preferredSize = const Size.fromHeight(56.0),
  });

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    if (isSearching) {
      return PlatformAppBar(
        title: title,
        backgroundColor: backgroundColor,
        leading: leading,
        android: (BuildContext context) => MaterialAppBarData(
                title: MaterialSearchBar(
                  search: search,
                  onSearchChanged: onChanged,
                ),
                actions: <Widget>[
                  PlatformIconButton(
                    icon: const Icon(Icons.search),
                    iosIcon: const Icon(CupertinoIcons.search),
                    onPressed: onSearchPressed,
                  ),
                ]),
        ios: (BuildContext context) => CupertinoNavigationBarData(
              title: CupertinoSearchWidget(
                initialValue: search,
                onChanged: onChanged,
                alwaysShowAppBar: alwaysShowSearchBar,
                onCancel: onSearchPressed,
              ),
              transitionBetweenRoutes: ios?.transitionBetweenRoutes,
              heroTag: ios?.heroTag,
            ),
      );
    }

    return PlatformAppBar(
      backgroundColor: backgroundColor,
      leading: leading,
      title: title,
      trailingActions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Search',
          onPressed: onSearchPressed,
        ),
      ]..addAll(actions ?? []),
      ios: (BuildContext context) => ios,
      android: (BuildContext context) => android,
    );
  }
}
