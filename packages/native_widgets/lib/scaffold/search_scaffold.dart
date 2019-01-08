part of native_widgets;

// class NativeSearchScaffold extends StatefulWidget {
//   final Widget child, title;

//   NativeSearchScaffold({
//     @required this.title,
//     this.child,
//   });

//   @override
//   _NativeSearchScaffoldState createState() => _NativeSearchScaffoldState();
// }

// class _NativeSearchScaffoldState extends State<NativeSearchScaffold>
//     with SingleTickerProviderStateMixin {
//   TextStyle searchText;
//   Color searchBackground, searchIconColor, searchCursorColor;

//   TextEditingController _searchTextController;
//   FocusNode _searchFocusNode = new FocusNode();
//   Animation _animation;
//   AnimationController _animationController;

//   @override
//   void initState() {
//     _searchTextController = TextEditingController();

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
//     _startSearch();
//     super.initState();
//   }

//   void _startSearch() {
//     _searchTextController.clear();
//     _animationController.forward();
//   }

//   void _cancelSearch() {
//     // if (widget.alwaysShowAppBar) {
//     _searchTextController.clear();
//     _searchFocusNode.unfocus();
//     _animationController.reverse();
//     // }
//     // widget.onSearchPressed();
//   }

//   void _clearSearch() {
//     _searchTextController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (Platform.isIOS) {
//       return CupertinoPageScaffold(
//         child: CustomScrollView(
//           semanticChildCount: 2,
//           slivers: <Widget>[
//             CupertinoSliverNavigationBar(
//               largeTitle: widget.title,
//               trailing: Icon(CupertinoIcons.info),
//               leading: Icon(CupertinoIcons.music_note),
//             ),
//             SliverFillRemaining(
//                 child: Column(
//               children: <Widget>[
//                 new IOSSearchBar(
//                   controller: _searchTextController,
//                   focusNode: _searchFocusNode,
//                   animation: _animation,
//                   onCancel: _cancelSearch,
//                   onClear: _clearSearch,
//                   // onUpdate: widget?.onChanged,
//                 ),
//                 widget?.child ?? Container(),
//               ],
//             )),
//           ],
//         ),
//       );
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title: widget.title,
//       ),
//       body: widget?.child ?? Container(),
//     );
//   }
// }
