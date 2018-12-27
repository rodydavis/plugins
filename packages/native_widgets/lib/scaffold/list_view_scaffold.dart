// Alphabetial Search on Side
// Editing Mode with Reorder and Delete
// Swipe to Delete Actions

part of native_widgets;

/// iOS Table View Controller Functionality
class NativeListViewScaffold extends StatelessWidget {
  // Make Stateful for Editing, Refreshing, Searching
  final String title, previousTitle;
  final List<dynamic> items;
  final Widget trailing;
  // final Function(BuildContext context, int index) item;
  final VoidCallback viewDetails, onEditingComplete, onEditingStarted;
  final ValueChanged<dynamic> onCellTap;
  final ValueChanged<List<dynamic>> selectedItemsChanged;
  final Duration refreshDuration;
  final RefreshCallback onRefresh;
  final NativeListViewScaffoldData ios;

  const NativeListViewScaffold({
    // this.item,
    this.items,
    this.viewDetails,
    this.onEditingComplete,
    this.onEditingStarted,
    this.previousTitle,
    this.title,
    this.trailing,
    this.selectedItemsChanged,
    this.onCellTap,
    this.onRefresh,
    this.ios,
    this.refreshDuration = const Duration(seconds: 3),
  });

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (BuildContext context) {
        return CupertinoTableViewController(
          action: trailing,
          title: title,
          onRefresh: onRefresh,
          selectedItems: selectedItemsChanged,
          previousTitle: previousTitle,
          onCellTap: onCellTap,
          items: items,
          cellAccessory: ios?.cellAccessory,
          cellEditingAccessory: ios?.cellEditingAccessory,
          cellEditingAction: ios?.cellEditingAction,
          onCellAccessoryTap: ios?.onCellAccessoryTap,
          onCellEditingAccessoryTap: ios?.onCellEditingAccessoryTap,
          onEditing: (bool editing) {
            if (editing != null) {
              if (editing) {
                if (onEditingStarted != null) onEditingStarted();
              } else {
                if (onEditingComplete != null) onEditingComplete();
              }
            }
          },
        );
      },
      android: (BuildContext context) {
        return Container();
      },
    );
  }
}

typedef RefreshCallback = Future<List<dynamic>> Function();

class NativeListViewScaffoldData {
  final CupertinoEditingAction cellEditingAction;
  final CupertinoAccessory cellAccessory;
  final CupertinoEditingAccessory cellEditingAccessory;
  final ValueChanged<dynamic> onCellEditingAccessoryTap, onCellAccessoryTap;

  NativeListViewScaffoldData({
    this.onCellAccessoryTap,
    this.onCellEditingAccessoryTap,
    this.cellEditingAction = CupertinoEditingAction.select,
    this.cellAccessory = CupertinoAccessory.disclosureIndicator,
    this.cellEditingAccessory = CupertinoEditingAccessory.detail,
  });
}
