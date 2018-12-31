// Alphabetial Search on Side
// Editing Mode with Reorder and Delete
// Swipe to Delete Actions

part of native_widgets;

/// iOS Table View Controller Functionality
class NativeListViewScaffold extends StatelessWidget {
  final String title, previousTitle;
  final Widget leading, trailing;
  final VoidCallback viewDetails, onEditingComplete, onEditingStarted;
  final Duration refreshDuration;
  final RefreshCallback onRefresh;
  final CupertinoListViewData ios;
  final bool showListTabs, hideAppBarOnSearch;
  final bool isEditing, isSearching;
  final ValueChanged<bool> onEditing;
  final List<NativeListViewSection> sections;
  final List<Widget> widgets;

  NativeListViewScaffold({
    // this.item,
    this.viewDetails,
    this.onEditingComplete,
    this.onEditingStarted,
    this.previousTitle,
    this.title,
    this.trailing,
    this.leading,
    this.onRefresh,
    this.ios,
    this.hideAppBarOnSearch = false,
    this.showListTabs = false,
    this.refreshDuration = const Duration(seconds: 3),
    this.isSearching = false,
    this.isEditing = false,
    this.onEditing,
    List<Widget> children = const <Widget>[],
    this.widgets,
  }) : sections = [NativeListViewSection(children: children)];

  NativeListViewScaffold.builder({
    // this.item,
    this.viewDetails,
    this.onEditingComplete,
    this.onEditingStarted,
    this.previousTitle,
    this.title,
    this.trailing,
    this.leading,
    this.onRefresh,
    this.hideAppBarOnSearch = false,
    this.ios,
    this.showListTabs = false,
    this.refreshDuration = const Duration(seconds: 3),
    this.isSearching = false,
    this.isEditing = false,
    this.onEditing,
    @required IndexedWidgetBuilder itemBuilder,
    int itemCount,
    this.widgets,
  }) : sections = [
          NativeListViewSection.builder(
            itemBuilder: itemBuilder,
            itemCount: itemCount,
          )
        ];

  const NativeListViewScaffold.sectioned({
    // this.item,
    this.viewDetails,
    this.onEditingComplete,
    this.onEditingStarted,
    this.previousTitle,
    this.title,
    this.trailing,
    this.hideAppBarOnSearch = false,
    this.leading,
    this.onRefresh,
    this.ios,
    this.showListTabs = false,
    this.refreshDuration = const Duration(seconds: 3),
    this.isSearching = false,
    this.isEditing = false,
    this.onEditing,
    @required this.sections,
    this.widgets,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (BuildContext context) {
        return CupertinoTableViewController(
          leading: leading,
          trailing: trailing,
          title: title,
          onRefresh: onRefresh,
          hideAppBarOnSearch: hideAppBarOnSearch,
          previousTitle: previousTitle,
          onEditing: onEditing,
          isEditing: isEditing,
          isSearching: isSearching,
          widgets: widgets,
          showEditingButtonLeft: ios?.showEditingButtonLeft,
          showEditingButtonRight: ios?.showEditingButtonRight,
          sections: sections
              .map(
                  (NativeListViewSection item) => new CupertinoTableViewSection(
                        header: item?.header == null ? null : item.header,
                        childrenDelegate: item.childrenDelegate,
                      ))
              .toList(),
        );
      },
      android: (BuildContext context) {
        return Container();
      },
    );
  }
}

typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index);

class NativeListViewSection {
  final Widget header;
  final SliverChildDelegate childrenDelegate;

  NativeListViewSection({
    this.header,
    @required List<Widget> children = const <Widget>[],
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
  }) : childrenDelegate = SliverChildListDelegate(
          children,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        );

  NativeListViewSection.builder({
    this.header,
    @required IndexedWidgetBuilder itemBuilder,
    int itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
  }) : childrenDelegate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        );
}

typedef RefreshCallback = Future<List<dynamic>> Function();

class CupertinoListViewData {
  final bool showEditingButtonLeft, showEditingButtonRight;

  const CupertinoListViewData({
    this.showEditingButtonLeft = false,
    this.showEditingButtonRight = false,
  });
}
