import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../utils/ios_search_bar.dart';

// class CupertinoSearchBar extends StatefulWidget {
//   final TextStyle searchText;
//   final Color searchBackground, searchIconColor, searchCursorColor;
//   final ValueChanged<String> onChanged;
//   // final ValueChanged<bool> onSearching;
//   final VoidCallback onCancel, onSearch;
//   final String initialValue;
//   final bool alwaysShowAppBar;

//   const CupertinoSearchBar({
//     this.searchBackground,
//     this.searchCursorColor,
//     this.searchIconColor,
//     this.searchText,
//     this.onChanged,
//     this.initialValue,
//     this.alwaysShowAppBar = false,
//     this.onCancel,
//     this.onSearch,
//     // this.isSearching = false,
//   });

//   @override
//   CupertinoSearchBarState createState() {
//     return new CupertinoSearchBarState();
//   }
// }

// class CupertinoSearchBarState extends State<CupertinoSearchBar>
//     with SingleTickerProviderStateMixin {
//   TextStyle searchText;
//   Color searchBackground, searchIconColor, searchCursorColor;

//   TextEditingController _searchTextController;
//   FocusNode _searchFocusNode = new FocusNode();
//   Animation _animation;
//   AnimationController _animationController;

//   @override
//   void initState() {
//     _searchTextController = TextEditingController(text: widget.initialValue);

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
//       // if (_searchFocusNode.hasFocus) {
//       //   _animationController.forward();
//       // } else {
//       //   _animationController.reverse();
//       // }
//     });
//     if (!widget.alwaysShowAppBar ) {
//       _startSearch();
//     }
//     super.initState();
//   }

//   void _startSearch() {
//     _searchTextController.clear();
//     _animationController.forward();
//   }

//   void _cancelSearch() {
//     if (widget.alwaysShowAppBar) {
//       _searchTextController.clear();
//       _searchFocusNode.unfocus();
//       _animationController.reverse();
//     }
//     if (widget?.onCancel != null) widget.onCancel();
//   }

//   void _clearSearch() {
//     _searchTextController.clear();
//     widget?.onChanged("");
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     _searchFocusNode.dispose();
//     _searchTextController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!widget.alwaysShowAppBar)
//       FocusScope.of(context).requestFocus(_searchFocusNode);

//     return new IOSSearchBar(
//       controller: _searchTextController,
//       focusNode: _searchFocusNode,
//       animation: _animation,
//       onCancel: _cancelSearch,
//       onClear: _clearSearch,
//       onUpdate: widget?.onChanged,
//       onSearch: widget?.onSearch,
//       autoFocus: false,
//     );
//   }
// }

class CupertinoSearchBar extends AnimatedWidget {
  const CupertinoSearchBar({
    Key key,
    this.controller,
    this.focusNode,
    this.onCancel,
    this.onChanged,
    this.onSubmitted,
    this.autoFocus = false,
    this.animation,
    this.onClear,
    this.enabled = true,
  })  : assert(controller != null),
        assert(focusNode != null),
        super(key: key, listenable: animation);

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged, onSubmitted;
  final VoidCallback onCancel, onClear;
  final bool autoFocus, enabled;
  final Animation<double> animation;

  static final _opacityTween = new Tween(begin: 1.0, end: 0.0);
  static final _paddingTween = new Tween(begin: 0.0, end: 60.0);
  static final _kFontSize = 13.0;
  // static final Key _inputKey = new Key(debugLabel: 'searchBox');

  @override
  Widget build(BuildContext context) {
    // if (!widget.alwaysShowAppBar)
    //   FocusScope.of(context).requestFocus(_searchFocusNode);

    return new Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              decoration: new BoxDecoration(
                color: CupertinoColors.lightBackgroundGray,
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
                          child: enabled
                              ? new EditableText(
                                  key: Key("Search_Input_Box"),
                                  controller: controller,
                                  focusNode: focusNode,
                                  onChanged: onChanged,
                                  autofocus: autoFocus,
                                  onSubmitted: onSubmitted,
                                  style: new TextStyle(
                                    color: CupertinoColors.black,
                                    inherit: false,
                                    fontSize: _kFontSize,
                                  ),
                                  cursorColor: CupertinoColors.black,
                                  backgroundCursorColor: Colors.grey,
                                )
                              : null,
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
                  color: CupertinoColors.activeBlue,
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
