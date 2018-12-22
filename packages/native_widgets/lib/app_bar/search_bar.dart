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
                  IconButton(
                    icon: const Icon(Icons.search),
                    tooltip: 'Search',
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

// class SearchPage extends StatefulWidget {
//   SearchPage();

//   createState() => new SearchPageState();
// }

// class SearchPageState extends State<SearchPage>
//     with SingleTickerProviderStateMixin {
//   SearchPageState();

//   TextEditingController _searchTextController = new TextEditingController();
//   FocusNode _searchFocusNode = new FocusNode();
//   Animation _animation;
//   AnimationController _animationController;

//   @override
//   void initState() {
//     super.initState();

//     _animationController = new AnimationController(
//       duration: new Duration(milliseconds: 200),
//       vsync: this,
//     );
//     _animation = new CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//       reverseCurve: Curves.easeInOut,
//     );
//     _searchFocusNode.addListener(() {
//       if (!_animationController.isAnimating) {
//         _animationController.forward();
//       }
//     });
//   }

//   void _cancelSearch() {
//     _searchTextController.clear();
//     _searchFocusNode.unfocus();
//     _animationController.reverse();
//   }

//   void _clearSearch() {
//     _searchTextController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new CupertinoPageScaffold(
//       navigationBar: new CupertinoNavigationBar(
//         middle: new IOSSearchBar(
//           controller: _searchTextController,
//           focusNode: _searchFocusNode,
//           animation: _animation,
//           onCancel: _cancelSearch,
//           onClear: _clearSearch,
//         ),
//       ),
//       child: new GestureDetector(
//         onTapUp: (TapUpDetails _) {
//           _searchFocusNode.unfocus();
//           if (_searchTextController.text == '') {
//             _animationController.reverse();
//           }
//         },
//         child: new Container(), // Add search body here
//       ),
//     );
//   }
// }

/// Creates the Cupertino-style search bar. See the README for an example on how to use.
class IOSSearchBar extends AnimatedWidget {
  /// https://github.com/dnys1/ios_search_bar
  IOSSearchBar({
    Key key,
    @required Animation<double> animation,
    @required this.controller,
    @required this.focusNode,
    this.onCancel,
    this.onClear,
    this.onSubmit,
    this.onUpdate,
  })  : assert(controller != null),
        assert(focusNode != null),
        super(key: key, listenable: animation);

  /// The text editing controller to control the search field
  final TextEditingController controller;

  /// The focus node needed to manually unfocus on clear/cancel
  final FocusNode focusNode;

  /// The function to call when the "Cancel" button is pressed
  final Function onCancel;

  /// The function to call when the "Clear" button is pressed
  final Function onClear;

  /// The function to call when the text is updated
  final Function(String) onUpdate;

  /// The function to call when the text field is submitted
  final Function(String) onSubmit;

  static final _opacityTween = new Tween(begin: 1.0, end: 0.0);
  static final _paddingTween = new Tween(begin: 0.0, end: 60.0);
  static final _kFontSize = 13.0;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              decoration: new BoxDecoration(
                color: CupertinoColors.white,
                border:
                    new Border.all(width: 0.0, color: CupertinoColors.white),
                borderRadius: new BorderRadius.circular(10.0),
              ),
              child: new Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 1.0),
                        child: new Icon(
                          CupertinoIcons.search,
                          color: CupertinoColors.inactiveGray,
                          size: _kFontSize + 2.0,
                        ),
                      ),
                      new Text(
                        'Search',
                        style: new TextStyle(
                          inherit: false,
                          color: CupertinoColors.inactiveGray
                              .withOpacity(_opacityTween.evaluate(animation)),
                          fontSize: _kFontSize,
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: new EditableText(
                            controller: controller,
                            focusNode: focusNode,
                            onChanged: onUpdate,
                            autofocus: true,
                            onSubmitted: onSubmit,
                            style: new TextStyle(
                              color: CupertinoColors.black,
                              inherit: false,
                              fontSize: _kFontSize,
                            ),
                            cursorColor: CupertinoColors.black,
                            backgroundCursorColor: Colors.grey,
                          ),
                        ),
                      ),
                      new CupertinoButton(
                        minSize: 10.0,
                        padding: const EdgeInsets.all(1.0),
                        borderRadius: new BorderRadius.circular(30.0),
                        color: CupertinoColors.inactiveGray.withOpacity(
                          1.0 - _opacityTween.evaluate(animation),
                        ),
                        child: new Icon(
                          Icons.close,
                          size: 8.0,
                          color: CupertinoColors.white,
                        ),
                        onPressed: () {
                          if (animation.isDismissed)
                            return;
                          else
                            onClear();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          new SizedBox(
            width: _paddingTween.evaluate(animation),
            child: new CupertinoButton(
              padding: const EdgeInsets.only(left: 8.0),
              onPressed: onCancel,
              child: new Text(
                'Cancel',
                softWrap: false,
                style: new TextStyle(
                  inherit: false,
                  color: Theme.of(context).textTheme.title.color,
                  fontSize: _kFontSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
