part of native_widgets;

class NativeSearchAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final bool isSearching;
  final String search;
  final Widget leading, title;
  final List<Widget> actions;
  final ValueChanged<String> onChanged;
  final VoidCallback onSearchPressed;
  final MaterialAppBarData materialAppBarData;
  final CupertinoNavigationBarData cupertinoNavigationBarData;
  final Color backgroundColor;

  NativeSearchAppBar({
    this.isSearching = false,
    this.onChanged,
    this.cupertinoNavigationBarData,
    this.materialAppBarData,
    this.onSearchPressed,
    this.search,
    this.leading,
    this.title,
    this.actions,
    this.backgroundColor,
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
                title: _MaterialSearchBar(
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
              title: _CupertinoSearchBar(
                initialValue: search,
                onChanged: onChanged,
                onSearchPressed: onSearchPressed,
              ),
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
      ios: (BuildContext context) => cupertinoNavigationBarData,
      android: (BuildContext context) => materialAppBarData,
    );
  }
}

class _CupertinoSearchBar extends StatefulWidget {
  final TextStyle searchText;
  final Color searchBackground, searchIconColor, searchCursorColor;
  final ValueChanged<String> onChanged;
  final String initialValue;
  final VoidCallback onSearchPressed;

  _CupertinoSearchBar({
    this.searchBackground,
    this.searchCursorColor,
    this.searchIconColor,
    this.searchText,
    this.onChanged,
    this.initialValue,
    this.onSearchPressed,
  });

  @override
  _CupertinoSearchBarState createState() {
    return new _CupertinoSearchBarState();
  }
}

class _CupertinoSearchBarState extends State<_CupertinoSearchBar>
    with SingleTickerProviderStateMixin {
  TextStyle searchText;
  Color searchBackground, searchIconColor, searchCursorColor;

  TextEditingController _searchTextController;
  FocusNode _searchFocusNode = new FocusNode();
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _searchTextController = TextEditingController(text: widget.initialValue);

    _animationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _searchFocusNode.addListener(() {
      if (!_animationController.isAnimating) {
        _animationController.forward();
      }
    });
    _startSearch();
    super.initState();
  }

  void _startSearch() {
    _searchTextController.clear();
    // _searchFocusNode.unfocus();
    _animationController.forward();
  }

  void _cancelSearch() {
    // _searchTextController.clear();
    // _searchFocusNode.unfocus();
    // _animationController.reverse();
    widget.onSearchPressed();
  }

  void _clearSearch() {
    _searchTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_searchFocusNode);
    // return DecoratedBox(
    //   decoration: BoxDecoration(
    //     color: searchBackground,
    //     borderRadius: BorderRadius.circular(10.0),
    //   ),
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(
    //       horizontal: 4.0,
    //       vertical: 8.0,
    //     ),
    //     child: Row(
    //       children: <Widget>[
    //         Icon(
    //           CupertinoIcons.search,
    //           color: searchIconColor,
    //         ),
    //         Expanded(
    //           child: EditableText(
    //             autofocus: true,
    //             autocorrect: false,
    //             controller: _searchTextController,
    //             focusNode: _searchFocusNode,
    //             style: Theme.of(context).textTheme.title,
    //             cursorColor: Colors.grey,
    //             onChanged: widget?.onChanged,
    //             backgroundCursorColor: Colors.transparent,
    //           ),
    //         ),
    //         GestureDetector(
    //           onTap: () {
    //             if (_searchTextController?.text?.isEmpty ?? false) {
    //               widget.onSearchPressed();
    //             } else {
    //               _searchTextController.clear();
    //             }
    //           },
    //           child: Icon(
    //             CupertinoIcons.clear_thick_circled,
    //             color: searchIconColor,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return new IOSSearchBar(
      controller: _searchTextController,
      focusNode: _searchFocusNode,
      animation: _animation,
      onCancel: _cancelSearch,
      onClear: _clearSearch,
      onUpdate: widget?.onChanged,
    );
  }
}

class _MaterialSearchBar extends StatelessWidget {
  final String search, name;

  final bool isSearching;

  final Function(String) onSearchChanged;

  _MaterialSearchBar({
    this.search,
    this.name,
    this.onSearchChanged,
    this.isSearching = false,
  });

  @override
  Widget build(BuildContext context) {
    var title = name ?? "search".toString();
    var _theme = Theme.of(context);

    if (isSearching) {
      return Container(
        padding: const EdgeInsets.only(left: 8.0),
        height: 38.0,
        margin: EdgeInsets.only(bottom: 2.0),
        decoration: BoxDecoration(
          color: _theme?.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: TextField(
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.search),
              ),
              border: InputBorder.none,
              hintText: 'Search'),
          autofocus: true,
          autocorrect: false,
          onChanged: (String value) => onSearchChanged(value),
        ),
      );
    }

    return Text(title);
  }
}