// Alphabetial Search on Side
// Editing Mode with Reorder and Delete
// Swipe to Delete Actions
// Sliver Lists

part of native_widgets;

/// iOS Table View Controller Functionality
class NativeListViewScaffold extends StatelessWidget {
  // Make Stateful for Editing, Refreshing, Searching
  final String title, previousTitle;
  final List<NativeListTile> items;
  final Widget trailing;
  // final Function(BuildContext context, int index) item;
  final VoidCallback viewDetails, onEditingComplete, onEditingStarted;
  final ValueChanged<NativeListTile> onItemTap;
  final Duration refreshDuration;
  final RefreshCallback onRefresh;

  NativeListViewScaffold({
    // this.item,
    this.items,
    this.viewDetails,
    this.onEditingComplete,
    this.onEditingStarted,
    this.previousTitle,
    this.title,
    this.trailing,
    this.onItemTap,
    this.onRefresh,
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
          // item: item,
          previousTitle: previousTitle,
          onItemTap: onItemTap,
          items: items,
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

class CupertinoTableViewController extends StatefulWidget {
  final String title, previousTitle;
  final Widget action;
  final ValueChanged<bool> onEditing;
  final ValueChanged<NativeListTile> onItemTap;
  final List<NativeListTile> items;
  final Duration refreshDuration;
  final RefreshCallback onRefresh;

  CupertinoTableViewController({
    @required this.title,
    this.previousTitle = "Back",
    this.action,
    this.onEditing,
    this.onItemTap,
    this.items,
    this.onRefresh,
    this.refreshDuration = const Duration(seconds: 3),
  });

  @override
  _CupertinoTableViewControllerState createState() =>
      _CupertinoTableViewControllerState();
}

class _CupertinoTableViewControllerState
    extends State<CupertinoTableViewController> {
  List<List<String>> randomizedContacts;
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  List<CupertinoTableCell<NativeListTile>> _items = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  bool _isEditing = false;

  void _init({List<NativeListTile> newItems}) {
    setState(() {
      if (newItems != null) {
        _items = newItems
            .map((NativeListTile item) =>
                new CupertinoTableCell<NativeListTile>(
                    selected: item?.selected ?? false,
                    data: item,
                    editable: true))
            .toList();
      } else {
        _items = widget.items
            .map((NativeListTile item) =>
                new CupertinoTableCell<NativeListTile>(
                    selected: item?.selected ?? false,
                    data: item,
                    editable: true))
            .toList();
      }
    });
  }

  void _deselectAll() {
    for (var item in _items) {
      setState(() {
        item.selected = false;
      });
    }
  }

  void _selectAll() {
    for (var item in _items) {
      setState(() {
        item.selected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _editingButton = Container(
      padding: EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        onTap: () {
          if (!_isDisposed)
            setState(() {
              _isEditing = !_isEditing;
            });
          if (widget?.onEditing != null) widget.onEditing(_isEditing);
          if (!_isEditing) _deselectAll();
        },
        child: _isEditing
            ? const Text("Cancel",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.activeBlue,
                ))
            : const Text("Edit",
                style: TextStyle(
                  color: CupertinoColors.activeBlue,
                )),
      ),
    );
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.title,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text(widget?.title ?? "Title"),
              // We're specifying a back label here because the previous page
              // is a Material page. CupertinoPageRoutes could auto-populate
              // these back labels.
              previousPageTitle: widget?.previousTitle ?? "",
              leading: widget?.previousTitle != null
                  ? _isEditing ? null : widget?.action
                  : _editingButton,
              trailing: widget?.previousTitle != null
                  ? _editingButton
                  : _isEditing ? null : widget?.action,
            ),
            CupertinoSliverRefreshControl(
              onRefresh: () {
                setState(() {
                  _items?.clear();
                });
                return widget.onRefresh().then((newItems) {
                  _init(newItems: newItems);
                });
              },
            ),
            SliverSafeArea(
              top: false, // Top safe area is consumed by the navigation bar.
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    CupertinoTableCell _cell = _items[index];
                    NativeListTile _item = _cell?.data;

                    return GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        if (_isEditing) {
                          print("On Tap Down..");
                          setState(() {
                            _cell.selected = !_cell.selected;
                          });
                        } else {
                          setState(() {
                            _cell.selected = true;
                          });
                        }
                      },
                      onTapCancel: () {
                        if (_isEditing) {
                          print("On Tap Cancel..");
                          setState(() {
                            _cell.selected = !_cell.selected;
                          });
                        } else {
                          setState(() {
                            _cell.selected = false;
                          });
                        }
                      },
                      child: NativeListTile(
                        editing: _isEditing,
                        selected: _cell.selected,
                        lastItem: index == _items.length,
                        avatar: _item?.avatar,
                        leading: _item?.leading,
                        title: _item?.title,
                        subtitle: _item?.subtitle,
                        trailing: _item?.trailing,
                        ios: CupertinoListTileData(
                          hideLeadingIcon: _item?.ios?.hideLeadingIcon,
                          style: _item?.ios?.style,
                          accessory: _item?.ios?.accessory,
                          editingAction: _item?.ios?.editingAction,
                          editingAccessory: _item?.ios?.editingAccessory,
                          accessoryTap: _item?.ios?.accessoryTap,
                        ),
                        onTap: () {
                          if (!_isEditing) {
                            print("Item Tapped...");
                            setState(() {
                              _cell.selected = false;
                            });
                            if (widget?.onItemTap != null)
                              widget.onItemTap(_cell?.data);
                          }
                        },
                      ),
                    );
                  },
                  childCount: _items.length,
                ),
              ),
            ),
          ],
        ),
        persistentFooterButtons: !_isEditing
            ? null
            : <Widget>[
                NativeToolBar(
                  height: 35.0,
                  leading: NativeTextButton(
                    label: "Select All",
                    onPressed: () => _selectAll(),
                  ),
                  trailing: NativeTextButton(
                    label: "Delete",
                  ),
                ),
              ],
      ),
    );
  }
}

typedef RefreshCallback = Future<List<NativeListTile>> Function();

class CupertinoTableCell<T> {
  bool selected;
  final bool editable;
  dynamic data;

  CupertinoTableCell({
    this.selected = false,
    this.editable = true,
    this.data,
  });
}
