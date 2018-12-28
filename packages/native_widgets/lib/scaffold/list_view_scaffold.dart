// Alphabetial Search on Side
// Editing Mode with Reorder and Delete
// Swipe to Delete Actions

part of native_widgets;

/// iOS Table View Controller Functionality
class NativeListViewScaffold extends StatelessWidget {
  // Make Stateful for Editing, Refreshing, Searching
  final String title, previousTitle;
  final Widget leading, trailing;
  // final Function(BuildContext context, int index) item;
  final VoidCallback viewDetails, onEditingComplete, onEditingStarted;
  final ValueChanged<dynamic> onCellTap;
  final ValueChanged<List<dynamic>> selectedItemsChanged;
  final Duration refreshDuration;
  final RefreshCallback onRefresh;
  final CupertinoListViewData ios;
  final bool showListTabs, showSearchBar;
  final bool isEditing, isSearching;
  final ValueChanged<bool> onEditing, onSearch;
  final List<NativeListViewSection> sections;
  final List<Widget> widgets;

  const NativeListViewScaffold({
    // this.item,
    this.viewDetails,
    this.onEditingComplete,
    this.onEditingStarted,
    this.previousTitle,
    this.title,
    this.trailing,
    this.leading,
    this.selectedItemsChanged,
    this.onCellTap,
    this.onRefresh,
    this.ios,
    this.showListTabs = false,
    this.showSearchBar = true,
    this.refreshDuration = const Duration(seconds: 3),
    this.isSearching = false,
    this.isEditing = false,
    this.onSearch,
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
          previousTitle: previousTitle,
          showSearchBar: showSearchBar,
          onEditing: onEditing,
          onSearch: onSearch,
          isEditing: isEditing,
          isSearching: isSearching,
          widgets: widgets,
          showEditingButtonLeft: ios?.showEditingButtonLeft,
          showEditingButtonRight: ios?.showEditingButtonRight,
          sections: sections
              .map((NativeListViewSection item) =>
                  new CupertinoTableViewSection(
                      header: item?.header, items: item?.items))
              .toList(),
        );
      },
      android: (BuildContext context) {
        return Container();
      },
    );
  }
}

class NativeListViewSection {
  final List<Widget> items;
  final Widget header;

  NativeListViewSection({
    this.header,
    @required this.items,
  });
}

typedef RefreshCallback = Future<List<dynamic>> Function();

class CupertinoListViewData {
  final bool showEditingButtonLeft, showEditingButtonRight;

  const CupertinoListViewData({
    this.showEditingButtonLeft = false,
    this.showEditingButtonRight = false,
  });
}
