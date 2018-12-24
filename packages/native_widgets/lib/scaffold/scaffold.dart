part of native_widgets;

// class NativeScaffold extends StatelessWidget {
//   final bool showMaterial, tabIcon, tabLabel, hideAppBar;
//   final Color backgroundColor;
//   final Widget body, title, leading;
//   final List<Widget> pages, actions;
//   final List<BottomNavigationBarItem> tabs;
//   final int initalIndex;
//   final ValueChanged<int> itemChanged;

//   /// Android Only
//   final bool androidTopNavigation;

//   /// Android only
//   final FloatingActionButton floatingActionButton;

//   /// Android only
//   final FloatingActionButtonLocation floatingActionButtonLocation;

//   /// Android only
//   final FloatingActionButtonAnimator floatingActionButtonAnimator;

//   /// Android only
//   final Drawer drawer;

//   NativeScaffold({
//     this.tabIcon = true,
//     this.tabLabel = true,
//     this.itemChanged,
//     this.showMaterial = false,
//     this.hideAppBar = false,

//     /// Shown when rows || pages == null
//     this.body,
//     this.tabs,
//     this.pages,
//     this.leading,
//     this.actions,
//     this.title,
//     this.backgroundColor,
//     this.initalIndex = 0,
//     this.androidTopNavigation = false,
//     this.floatingActionButton,
//     this.floatingActionButtonLocation,
//     this.floatingActionButtonAnimator,
//     this.drawer,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final bool _isIos = showCupertino(showMaterial: showMaterial);

//     if (_isIos) {
//       final Widget appBar = hideAppBar
//           ? null
//           : CupertinoNavigationBar(
//               leading: leading,
//               middle: title,
//               trailing: actions == null
//                   ? null
//                   : Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: actions.map((Widget item) => item).toList(),
//                     ),
//             );
//       if ((tabs == null || tabs.isEmpty) && (pages == null || pages.isEmpty)) {
//         return Scaffold(
//           body: CupertinoPageScaffold(
//             backgroundColor: backgroundColor,
//             navigationBar: appBar,
//             child: body ?? Container(),
//           ),
//         );
//       }
//       return Scaffold(
//         body: CupertinoPageScaffold(
//           backgroundColor: backgroundColor,
//           navigationBar: appBar,
//           child: CupertinoTabScaffold(
//             tabBar: CupertinoTabBar(
//               items: tabs,
//             ),
//             tabBuilder: (BuildContext context, int index) {
//               final Widget _currentPage = pages[index];
//               return Container(
//                 padding: hideAppBar ? null : EdgeInsets.only(top: 50.0),
//                 child: CupertinoTabView(
//                   builder: (BuildContext context) {
//                     return _currentPage;
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//       );
//     }
//     if ((tabs == null || tabs.isEmpty) && (pages == null || pages.isEmpty)) {
//       return Scaffold(
//         appBar: hideAppBar
//             ? null
//             : AppBar(
//                 leading: leading,
//                 title: title,
//                 actions: actions,
//               ),
//         body: body,
//         drawer: drawer,
//         floatingActionButton: floatingActionButton,
//         floatingActionButtonLocation: floatingActionButtonLocation,
//         floatingActionButtonAnimator: floatingActionButtonAnimator,
//       );
//     }

//     if (androidTopNavigation) {
//       return _AndroidPagesTop(
//         topTabChanged: (int index) {},
//         leading: leading,
//         actions: actions,
//         title: title,
//         tabs: tabs,
//         hideAppBar: hideAppBar,
//         pages: pages,
//         drawer: drawer,
//         tabIcon: tabIcon,
//         tabLabel: tabLabel,
//         floatingActionButton: floatingActionButton,
//         floatingActionButtonLocation: floatingActionButtonLocation,
//         floatingActionButtonAnimator: floatingActionButtonAnimator,
//       );
//     }

//     return _AndroidPagesBottom(
//       leading: leading,
//       actions: actions,
//       title: title,
//       hideAppBar: hideAppBar,
//       tabs: tabs,
//       initalIndex: initalIndex,
//       pages: pages,
//       drawer: drawer,
//       bottomTabChanged: (int index) {},
//       floatingActionButton: floatingActionButton,
//       floatingActionButtonLocation: floatingActionButtonLocation,
//       floatingActionButtonAnimator: floatingActionButtonAnimator,
//     );
//   }
// }

// class _AndroidPagesBottom extends StatefulWidget {
//   final int initalIndex;
//   final List<BottomNavigationBarItem> tabs;
//   final List<Widget> pages, actions;
//   final Widget title, leading;
//   final ValueChanged<int> bottomTabChanged;
//   final FloatingActionButton floatingActionButton;
//   final FloatingActionButtonLocation floatingActionButtonLocation;
//   final FloatingActionButtonAnimator floatingActionButtonAnimator;
//   final Drawer drawer;
//   final bool hideAppBar;

//   _AndroidPagesBottom({
//     this.initalIndex = 0,
//     this.tabs,
//     this.hideAppBar = false,
//     this.pages,
//     this.title,
//     this.bottomTabChanged,
//     this.floatingActionButton,
//     this.floatingActionButtonLocation,
//     this.floatingActionButtonAnimator,
//     this.drawer,
//     this.actions,
//     this.leading,
//   });

//   @override
//   __AndroidPagesBottomState createState() => __AndroidPagesBottomState();
// }

// class __AndroidPagesBottomState extends State<_AndroidPagesBottom> {
//   int _currentIndex = 0;

//   @override
//   void initState() {
//     onTabTapped(widget.initalIndex);
//     super.initState();
//   }

//   void onTabTapped(int index) {
//     widget.bottomTabChanged(index);
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: widget.hideAppBar
//           ? null
//           : AppBar(
//               leading: widget.leading,
//               title: widget.title,
//               actions: widget.actions,
//             ),
//       body: widget.pages[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: onTabTapped,
//         currentIndex: _currentIndex,
//         items: widget.tabs,
//       ),
//       drawer: widget.drawer,
//       floatingActionButton: widget.floatingActionButton,
//       floatingActionButtonLocation: widget.floatingActionButtonLocation,
//       floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
//     );
//   }
// }

// class _AndroidPagesTop extends StatefulWidget {
//   final bool tabIcon, tabLabel, hideAppBar;
//   final List<Widget> pages, actions;
//   final List<BottomNavigationBarItem> tabs;
//   final Widget title, leading;
//   final int initalIndex;
//   final ValueChanged<int> topTabChanged;
//   final FloatingActionButton floatingActionButton;
//   final FloatingActionButtonLocation floatingActionButtonLocation;
//   final FloatingActionButtonAnimator floatingActionButtonAnimator;
//   final Drawer drawer;

//   _AndroidPagesTop({
//     @required this.tabs,
//     @required this.pages,
//     this.hideAppBar = false,
//     this.title,
//     this.initalIndex = 0,
//     this.topTabChanged,
//     this.floatingActionButton,
//     this.floatingActionButtonLocation,
//     this.floatingActionButtonAnimator,
//     this.drawer,
//     this.leading,
//     this.actions,
//     this.tabLabel = true,
//     this.tabIcon = true,
//   });

//   @override
//   __AndroidPagesTopState createState() => __AndroidPagesTopState();
// }

// class __AndroidPagesTopState extends State<_AndroidPagesTop>
//     with SingleTickerProviderStateMixin {
//   TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(
//       vsync: this,
//       length: widget?.tabs?.length ?? 0,
//       initialIndex: widget.initalIndex,
//     );
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: widget.hideAppBar ? null : widget.leading,
//         title: widget.hideAppBar ? null : widget.title,
//         actions: widget.hideAppBar ? null : widget.actions,
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: widget.tabs.map((BottomNavigationBarItem tab) {
//             return InkWell(
//               onTap: () {
//                 widget.topTabChanged(_tabController?.index);
//               },
//               child: Tab(
//                 icon: widget.tabIcon ? tab?.icon : null,
//                 child: widget.tabLabel ? tab?.title : null,
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: widget.pages.map((Widget page) {
//           return page;
//         }).toList(),
//       ),
//       drawer: widget.drawer,
//       floatingActionButton: widget.floatingActionButton,
//       floatingActionButtonLocation: widget.floatingActionButtonLocation,
//       floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
//     );
//   }
// }

class NativeScaffold extends StatelessWidget {
  final Widget body;
  final NativeAppBar appBar;
  final NativeBottomTabBar bottomBar;

  NativeScaffold({
    this.body,
    this.appBar,
    this.bottomBar,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: appBar == null
          ? null
          : PlatformAppBar(
              leading: appBar?.leading,
              title: appBar?.title,
              trailingActions: appBar?.actions,
            ),
      body: body,
      bottomNavBar: bottomBar?.items == null
          ? null
          : PlatformNavBar(
              itemChanged: bottomBar?.onTap,
              items: bottomBar?.items,
            ),
    );
  }
}
