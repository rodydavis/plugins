part of native_widgets;

class NativeSearchAppBar extends StatelessWidget {
  final bool isSearching, persistantSearchBar;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final VoidCallback onSearchPressed;
  final MaterialAppBarData materialAppBarData;
  final CupertinoNavigationBarData cupertinoNavigationBarData;

  NativeSearchAppBar({
    this.isSearching = false,
    this.persistantSearchBar = false,
    this.onChanged,
    this.cupertinoNavigationBarData,
    this.materialAppBarData,
    this.initialValue,
    this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (isSearching) {
      return PlatformWidget(
        android: (BuildContext context) {
          return MaterialSearchBar(
            search: initialValue,
            onSearchChanged: onChanged,
          );
        },
        ios: (BuildContext context) {
          return CupertinoSearchBar(
            initialValue: initialValue,
            onChanged: onChanged,
          );
        },
      );
    }

    return PlatformAppBar(
      trailingActions: <Widget>[
        IconButton(
          icon: Icon(isSearching ? Icons.close : Icons.search),
          tooltip: 'Search',
          onPressed: onSearchPressed,
        ),
      ],
      ios: (BuildContext context) => cupertinoNavigationBarData,
      android: (BuildContext context) => materialAppBarData,
    );
  }
}

class CupertinoSearchBar extends StatefulWidget {
  final TextStyle searchText;
  final Color searchBackground, searchIconColor, searchCursorColor;
  final ValueChanged<String> onChanged;
  final String initialValue;

  CupertinoSearchBar({
    this.searchBackground,
    this.searchCursorColor,
    this.searchIconColor,
    this.searchText,
    this.onChanged,
    this.initialValue,
  });

  @override
  CupertinoSearchBarState createState() {
    return new CupertinoSearchBarState();
  }
}

class CupertinoSearchBarState extends State<CupertinoSearchBar> {
  TextEditingController controller;
  FocusNode focusNode;
  @override
  void initState() {
    focusNode = FocusNode();
    controller = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget.searchBackground,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4.0,
          vertical: 8.0,
        ),
        child: Row(
          children: [
            Icon(
              CupertinoIcons.search,
              color: widget.searchIconColor,
            ),
            Expanded(
              child: EditableText(
                controller: controller,
                focusNode: focusNode,
                style: widget.searchText,
                cursorColor: widget.searchCursorColor,
                onChanged: widget.onChanged,
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.clear();
              },
              child: Icon(
                CupertinoIcons.clear_thick_circled,
                color: widget.searchIconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MaterialSearchBar extends StatelessWidget {
  final String search, name;

  final bool isSearching;

  final Function(String) onSearchChanged;

  MaterialSearchBar({
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
          onChanged: (value) => onSearchChanged(value),
        ),
      );
    }

    return Text(title);
  }
}

class AppSearchButton extends StatelessWidget {
  final bool isSearching;
  final VoidCallback onSearchPressed;
  AppSearchButton({this.onSearchPressed, this.isSearching});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isSearching ? Icons.close : Icons.search),
      tooltip: 'Search',
      onPressed: onSearchPressed,
    );
  }
}

// /// Creates the Cupertino-style search bar. See the README for an example on how to use.
// class IOSSearchBar extends AnimatedWidget {
//   /// https://github.com/dnys1/ios_search_bar
//   IOSSearchBar({
//     Key key,
//     @required Animation<double> animation,
//     @required this.controller,
//     @required this.focusNode,
//     this.onCancel,
//     this.onClear,
//     this.onSubmit,
//     this.onUpdate,
//   })  : assert(controller != null),
//         assert(focusNode != null),
//         super(key: key, listenable: animation);

//   /// The text editing controller to control the search field
//   final TextEditingController controller;

//   /// The focus node needed to manually unfocus on clear/cancel
//   final FocusNode focusNode;

//   /// The function to call when the "Cancel" button is pressed
//   final Function onCancel;

//   /// The function to call when the "Clear" button is pressed
//   final Function onClear;

//   /// The function to call when the text is updated
//   final Function(String) onUpdate;

//   /// The function to call when the text field is submitted
//   final Function(String) onSubmit;

//   static final _opacityTween = new Tween(begin: 1.0, end: 0.0);
//   static final _paddingTween = new Tween(begin: 0.0, end: 60.0);
//   static final _kFontSize = 13.0;

//   @override
//   Widget build(BuildContext context) {
//     final Animation<double> animation = listenable;
//     return new Padding(
//       padding: const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
//       child: new Row(
//         children: <Widget>[
//           new Expanded(
//             child: new Container(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
//               decoration: new BoxDecoration(
//                 color: CupertinoColors.white,
//                 border:
//                     new Border.all(width: 0.0, color: CupertinoColors.white),
//                 borderRadius: new BorderRadius.circular(10.0),
//               ),
//               child: new Stack(
//                 alignment: Alignment.centerLeft,
//                 children: <Widget>[
//                   new Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       new Padding(
//                         padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 1.0),
//                         child: new Icon(
//                           CupertinoIcons.search,
//                           color: CupertinoColors.inactiveGray,
//                           size: _kFontSize + 2.0,
//                         ),
//                       ),
//                       new Text(
//                         'Search',
//                         style: new TextStyle(
//                           inherit: false,
//                           color: CupertinoColors.inactiveGray
//                               .withOpacity(_opacityTween.evaluate(animation)),
//                           fontSize: _kFontSize,
//                         ),
//                       ),
//                     ],
//                   ),
//                   new Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       new Expanded(
//                         child: new Padding(
//                           padding: const EdgeInsets.only(left: 20.0),
//                           child: new EditableText(
//                             controller: controller,
//                             focusNode: focusNode,
//                             onChanged: onUpdate,
//                             onSubmitted: onSubmit,
//                             style: new TextStyle(
//                               color: CupertinoColors.black,
//                               inherit: false,
//                               fontSize: _kFontSize,
//                             ),
//                             cursorColor: CupertinoColors.black,
//                           ),
//                         ),
//                       ),
//                       new CupertinoButton(
//                         minSize: 10.0,
//                         padding: const EdgeInsets.all(1.0),
//                         borderRadius: new BorderRadius.circular(30.0),
//                         color: CupertinoColors.inactiveGray.withOpacity(
//                           1.0 - _opacityTween.evaluate(animation),
//                         ),
//                         child: new Icon(
//                           Icons.close,
//                           size: 8.0,
//                           color: CupertinoColors.white,
//                         ),
//                         onPressed: () {
//                           if (animation.isDismissed)
//                             return;
//                           else
//                             onClear();
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           new SizedBox(
//             width: _paddingTween.evaluate(animation),
//             child: new CupertinoButton(
//               padding: const EdgeInsets.only(left: 8.0),
//               onPressed: onCancel,
//               child: new Text(
//                 'Cancel',
//                 softWrap: false,
//                 style: new TextStyle(
//                   inherit: false,
//                   color: CupertinoColors.white,
//                   fontSize: _kFontSize,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
