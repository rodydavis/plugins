// Alphabetial Search on Side
// Editing Mode with Reorder and Delete
// Swipe to Delete Actions
// Sliver Lists

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

typedef RefreshCallback = Future<List<NativeListTile>> Function();

class CupertinoTableViewController extends StatefulWidget {
  final String title, previousTitle;
  final Widget action;
  final ValueChanged<bool> onEditing;
  final ValueChanged<dynamic> onCellTap,
      onCellEditingAccessoryTap,
      onCellAccessoryTap;
  final List<dynamic> items;
  final Duration refreshDuration;
  final bool reorder;
  final RefreshCallback onRefresh;
  final List<IconSlideAction> leadingActions, trailingActions;
  final ValueChanged<List<dynamic>> selectedItems;
  final CupertinoEditingAction cellEditingAction;
  final CupertinoAccessory cellAccessory;
  final CupertinoEditingAccessory cellEditingAccessory;

  const CupertinoTableViewController({
    @required this.title,
    this.previousTitle = "Back",
    this.action,
    this.onEditing,
    this.selectedItems,
    this.onCellTap,
    this.items,
    this.onRefresh,
    this.reorder = true,
    this.refreshDuration = const Duration(seconds: 3),
    this.leadingActions,
    this.trailingActions,
    this.onCellAccessoryTap,
    this.onCellEditingAccessoryTap,
    this.cellEditingAction = CupertinoEditingAction.select,
    this.cellAccessory = CupertinoAccessory.disclosureIndicator,
    this.cellEditingAccessory = CupertinoEditingAccessory.detail,
  });

  @override
  _CupertinoTableViewControllerState createState() =>
      _CupertinoTableViewControllerState();
}

class _CupertinoTableViewControllerState
    extends State<CupertinoTableViewController> {
  final SlidableController slidableController = SlidableController();

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  List<CupertinoTableCell<dynamic>> _items = [];
  List<dynamic> selectedItems = <dynamic>[];

  @override
  void initState() {
    _init();
    super.initState();
  }

  bool _isEditing = false;

  void _init({List<dynamic> newItems}) {
    setState(() {
      if (newItems != null) {
        _items = newItems
            .map((dynamic item) => new CupertinoTableCell<dynamic>(
                selected: item?.selected ?? false, data: item, editable: true))
            .toList();
      } else {
        _items = widget.items
            .map((dynamic item) => new CupertinoTableCell<dynamic>(
                selected: item?.selected ?? false, data: item, editable: true))
            .toList();
      }
    });
  }

  void _deselectAll() {
    selectedItems.clear();
    for (var item in _items) {
      setState(() {
        item.selected = false;
      });
    }
    _updateSelectedItems();
  }

  void _selectAll() {
    for (var item in _items) {
      setState(() {
        item.selected = true;
      });
    }
    _updateSelectedItems();
  }

  void _updateSelectedItems() {
    selectedItems.clear();
    for (var item in _items) {
      if (item.selected) {
        selectedItems.add(item?.data);
      }
    }
    if (widget?.selectedItems != null && selectedItems.isNotEmpty)
      widget.selectedItems(selectedItems);
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
                      final CupertinoTableCell<dynamic> _cell = _items[index];
                      return _buildCell(
                        context,
                        cell: _cell,
                        lastItem: index == _items?.length,
                        index: index,
                      );
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

  Widget _buildCell(BuildContext context,
      {@required CupertinoTableCell<dynamic> cell,
      bool lastItem = true,
      int index = 0}) {
    Widget _child;
    // NativeListTile _item = cell?.data as NativeListTile;

    final CupertinoListTileData _ios = CupertinoListTileData(
      hideLeadingIcon: true,
      style: CupertinoCellStyle.custom,
      accessory: widget.cellAccessory,
      editingAction: widget.cellEditingAction,
      editingAccessory: widget.cellEditingAccessory,
      padding: null,
      editingAccessoryTap: () {
        if (widget?.onCellTap != null)
          widget.onCellEditingAccessoryTap(cell?.data);
      },
      accessoryTap: () {
        if (widget?.onCellTap != null) widget.onCellAccessoryTap(cell?.data);
      },
      editingActionTap: () {
        if (widget.cellEditingAction == CupertinoEditingAction.remove) {
          _removeCell(cell);
          // slidableController?.activeState?.open(
          //     actionType: SlideActionType.secondary,
          //     );
        }
      },
    );

    if (widget.cellEditingAction == CupertinoEditingAction.select) {
      _child = GestureDetector(
        onTapDown: (TapDownDetails details) {
          if (!_isEditing) {
            print("On Tap Down..");
            setState(() {
              cell.selected = true;
            });
          }
        },
        onTapCancel: () {
          if (!_isEditing) {
            print("On Tap Cancel..");
            setState(() {
              cell.selected = false;
            });
          }
        },
        child: NativeListTile(
          editing: _isEditing,
          selected: cell.selected,
          child: cell?.data,
          ios: _ios,
          lastItem: lastItem,
          onTap: () {
            if (!_isEditing) {
              print("Item Tapped...");
              setState(() {
                cell.selected = false;
              });
              if (widget?.onCellTap != null) widget.onCellTap(cell?.data);
            } else {
              print("On Tap Down..");
              setState(() {
                cell.selected = !cell.selected;
              });
              _updateSelectedItems();
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
          child: cell?.data,
          ios: _ios,
          lastItem: lastItem,
          onTap: () {
            if (!_isEditing) {
              print("Item Tapped...");
              setState(() {
                cell.selected = false;
              });
              if (widget?.onCellTap != null) widget.onCellTap(cell?.data);
            }
          },
        ),
      );
    }

    final List<Widget> _trailingActions = <Widget>[];

    if (widget?.trailingActions != null) {
      _trailingActions..addAll(widget.trailingActions);
    }

    _trailingActions.add(
      new IconSlideAction(
        caption: 'Delete',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () => _removeCell(cell),
      ),
    );

    return Slidable(
      key: Key(index.toString()),
      controller: slidableController,
      slideToDismissDelegate: new SlideToDismissDrawerDelegate(
        onDismissed: (SlideActionType actionType) {
          _removeCell(cell);
        },
      ),
      delegate: new SlidableScrollDelegate(),
      actionExtentRatio: 0.25,
      child: _child,
      actions: widget?.leadingActions,
      secondaryActions: _trailingActions,
    );
  }

  void _removeCell(CupertinoTableCell cell) {
    setState(() {
      _items.remove(cell);
    });
  }
}

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
