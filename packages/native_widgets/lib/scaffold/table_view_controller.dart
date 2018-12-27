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
  final bool reorder;
  final RefreshCallback onRefresh;

  CupertinoTableViewController({
    @required this.title,
    this.previousTitle = "Back",
    this.action,
    this.onEditing,
    this.onItemTap,
    this.items,
    this.onRefresh,
    this.reorder = true,
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
            //  if (widget.reorder) {
            //         return new DragAndDropList<
            //             CupertinoTableCell<NativeListTile>>(
            //           _items,
            //           itemBuilder: (BuildContext context,
            //               CupertinoTableCell<NativeListTile> item) {
            //             return _buildCell(context, cell: item);
            //           },
            //           onDragFinish: (before, after) {
            //             var data = _items[before];
            //             _items.removeAt(before);
            //             _items.insert(after, data);
            //           },
            //           canBeDraggedTo: (one, two) => true,
            //           dragElevation: 8.0,
            //         );
            //       }
            SliverSafeArea(
                top: false, // Top safe area is consumed by the navigation bar.
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final CupertinoTableCell<NativeListTile> _cell =
                          _items[index];
                      return _buildCell(context, cell: _cell);
                    },
                    childCount: _items.length,
                  ),
                )),
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

  Widget _buildCell(BuildContext context, {@required CupertinoTableCell cell}) {
    Widget _child;
    NativeListTile _item = cell?.data;
    if (_item?.ios?.editingAction == CupertinoEditingAction.select) {
      _child = GestureDetector(
        onTapDown: (TapDownDetails details) {
          if (_isEditing) {
            print("On Tap Down..");
            setState(() {
              cell.selected = !cell.selected;
            });
          } else {
            setState(() {
              cell.selected = true;
            });
          }
        },
        onTapCancel: () {
          if (_isEditing) {
            print("On Tap Cancel..");
            setState(() {
              cell.selected = !cell.selected;
            });
          } else {
            setState(() {
              cell.selected = false;
            });
          }
        },
        child: NativeListTile(
          editing: _isEditing,
          selected: cell.selected,
          // lastItem: index == _items.length,
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
                cell.selected = false;
              });
              if (widget?.onItemTap != null) widget.onItemTap(cell?.data);
            }
          },
        ),
      );
    } else {
      _child = GestureDetector(
        onTapDown: (TapDownDetails details) {
          if (!_isEditing) {
            setState(() {
              cell.selected = true;
            });
          }
        },
        onTapCancel: () {
          if (!_isEditing) {
            setState(() {
              cell.selected = false;
            });
          }
        },
        child: NativeListTile(
          editing: _isEditing,
          selected: cell.selected,
          // lastItem: index == _items.length,
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
                cell.selected = false;
              });
              if (widget?.onItemTap != null) widget.onItemTap(cell?.data);
            }
          },
        ),
      );
    }

    return Slidable(
      key: new Key(_item?.title?.data),
      // controller: slidableController,
      // direction: direction,
      slideToDismissDelegate: new SlideToDismissDrawerDelegate(
        onDismissed: (actionType) {
          // _showSnackBar(
          //     context,
          //     actionType == SlideActionType.primary
          //         ? 'Dismiss Archive'
          //         : 'Dimiss Delete');
          // setState(() {
          //   items.removeAt(index);
          // });
        },
      ),
      delegate: new SlidableScrollDelegate(),
      actionExtentRatio: 0.25,
      child: _child,
      actions: <Widget>[
        new IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          // onTap: () => _showSnackBar(context, 'Archive'),
        ),
        new IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          // onTap: () => _showSnackBar(context, 'Share'),
        ),
      ],
      secondaryActions: <Widget>[
        new IconSlideAction(
          caption: 'More',
          color: Colors.grey.shade200,
          icon: Icons.more_horiz,
          // onTap: () => _showSnackBar(context, 'More'),
          closeOnTap: false,
        ),
        new IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          // onTap: () => _showSnackBar(context, 'Delete'),
        ),
      ],
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
