// Alphabetial Search on Side
// Editing Mode with Reorder and Delete
// Swipe to Delete Actions
// Sliver Lists

part of native_widgets;

/// iOS Table View Controller Functionality
class NativeListViewScaffold extends StatelessWidget {
  // Make Stateful for Editing, Refreshing, Searching
  final List<dynamic> items;
  final Widget item;
  final VoidCallback viewDetails;

  NativeListViewScaffold({
    this.item,
    this.items,
    this.viewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (BuildContext context) {},
      android: (BuildContext context) {},
    );
  }
}
