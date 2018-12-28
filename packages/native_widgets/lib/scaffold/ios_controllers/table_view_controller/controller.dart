import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uuid/uuid.dart';

import '../../../native_widgets.dart';
import '../../../utils/ios_search_bar.dart';
import 'cell.dart';

typedef RefreshCallback = Future<List<dynamic>> Function();

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
  final RefreshCallback onRefresh, onSearch;
  final List<IconSlideAction> leadingActions, trailingActions;
  final ValueChanged<List<dynamic>> selectedItems;
  final CupertinoEditingAction cellEditingAction;
  final CupertinoAccessory cellAccessory;
  final CupertinoEditingAccessory cellEditingAccessory;
  final ValueChanged<String> onChanged;
  final String initialValue;
  final VoidCallback onSearchPressed;
  final bool alwaysShowAppBar;
  final bool showSegmentedControl;
  final bool showSearchBar;

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
    this.initialValue = "",
    this.onChanged,
    this.onSearch,
    this.onSearchPressed,
    this.onCellEditingAccessoryTap,
    this.onCellAccessoryTap,
    this.cellEditingAction = CupertinoEditingAction.select,
    this.cellAccessory = CupertinoAccessory.disclosureIndicator,
    this.cellEditingAccessory = CupertinoEditingAccessory.detail,
    this.alwaysShowAppBar = true,
    this.showSegmentedControl = false,
    this.showSearchBar = false,
  });

  @override
  _CupertinoTableViewControllerState createState() =>
      _CupertinoTableViewControllerState();
}

class _CupertinoTableViewControllerState
    extends State<CupertinoTableViewController>
    with SingleTickerProviderStateMixin {
  TextStyle searchText;
  Color searchBackground, searchIconColor, searchCursorColor;

  TextEditingController _searchTextController;
  FocusNode _searchFocusNode = new FocusNode();
  Animation _animation;
  AnimationController _animationController;
  final SlidableController slidableController = SlidableController();

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    _animationController.dispose();
    _searchFocusNode.dispose();
    _searchTextController.dispose();
    super.dispose();
  }

  List<CupertinoTableCell> _items = [];
  List<dynamic> selectedItems = <dynamic>[];

  @override
  void initState() {
    _init();
    _searchTextController = TextEditingController(text: widget.initialValue);

    _animationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _searchFocusNode.addListener(() {
      if (!_animationController.isAnimating) {
        _animationController.forward();
        setState(() {
          _isSearching = true;
        });
      } else {
        setState(() {
          _isSearching = false;
        });
      }
    });
    _cancelSearch();
    super.initState();
  }

  bool _isEditing = false;

  void _init({bool force = false}) {
    final Uuid uuid = new Uuid();
    setState(() {
      _items = widget.items
          .map((dynamic item) => new CupertinoTableCell(
                key: Key(uuid.v4()),
                slideableController: slidableController,
                onDelete: () {},
                onSelected: (bool selected) {},
                onTap: () {},
                selected: item?.selected ?? false,
                editing: _isEditing,
                child: item,
                canEdit: true,
                id: uuid.v4(),
              ))
          .toList();
    });
  }

  // -- Toolbar Buttons --

  void _deselectAll() {
    selectedItems.clear();
    for (var item in _items) {
      setState(() {
        // item.selected = false;
      });
    }
    _updateSelectedItems();
  }

  void _selectAll() {
    for (var item in _items) {
      setState(() {
        // item.selected = true;
      });
    }
    _updateSelectedItems();
  }

  void _deleteAll() {
    final List<CupertinoTableCell> _cellsToDelete = [];
    for (var item in _items) {
      if (item.selected) {
        _cellsToDelete.add(item);
      }
    }
    for (var item in _cellsToDelete) {
      setState(() {
        _items.remove(item);
      });
    }
    setState(() {
      _isEditing = false;
    });
  }

  void _updateSelectedItems() {
    selectedItems.clear();
    for (var item in _items) {
      if (item.selected) {
        selectedItems.add(item?.child);
      }
    }
    if (widget?.selectedItems != null && selectedItems.isNotEmpty)
      widget.selectedItems(selectedItems);
  }

  // -- Segmented Control --

  final Map<int, Widget> children = const <int, Widget>{
    0: Text('Midnight'),
    1: Text('Viridian'),
    2: Text('Cerulean'),
  };
  int sharedValue = 0;

  // -- Search Controller --

  bool _isSearching = false;

  void _startSearch() {
    _searchTextController.clear();
    _animationController.forward();
    setState(() {
      _isSearching = true;
    });
  }

  void _cancelSearch() {
    if (widget.alwaysShowAppBar) {
      _searchTextController?.clear();
      _searchFocusNode?.unfocus();
      _animationController?.reverse();
    }
    setState(() {
      _isSearching = false;
    });
    if (widget?.onSearchPressed != null) widget.onSearchPressed();
  }

  void _clearSearch() {
    _searchTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // FocusScope.of(context).requestFocus(_searchFocusNode);
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

    final _list = <Widget>[];

    if (!_isSearching) {
      _list.addAll([
        CupertinoSliverNavigationBar(
          heroTag: widget?.title ?? "Title",
          transitionBetweenRoutes: false,
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
            return widget.onRefresh().then((_) {
              _init();
            });
          },
        ),
      ]);
    }

    if (widget.showSearchBar) {
      _list.add(SliverSafeArea(
        bottom: false,
        top: _isSearching,
        sliver: SliverToBoxAdapter(
          child: IOSSearchBar(
            controller: _searchTextController,
            focusNode: _searchFocusNode,
            animation: _animation,
            onCancel: _cancelSearch,
            onClear: _clearSearch,
            onUpdate: widget?.onChanged,
            autoFocus: false,
          ),
        ),
      ));
    }

    if (widget.showSegmentedControl) {
      _list.add(SliverToBoxAdapter(
        child: CupertinoSegmentedControl<int>(
          children: children,
          onValueChanged: (int newValue) {
            setState(() {
              sharedValue = newValue;
            });
          },
          groupValue: sharedValue,
        ),
      ));
    }

    _list.add(SliverSafeArea(
        top: false, // Top safe area is consumed by the navigation bar.
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final CupertinoTableCell _cell = _items[index];
              // return _buildCell(
              //   context,
              //   cell: _cell,
              //   lastItem: index == _items?.length,
              //   index: index,
              // );
              return _cell;
            },
            childCount: _items.length,
          ),
        )));

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.title,
      child: Scaffold(
        body: CustomScrollView(primary: true, slivers: _list),
        persistentFooterButtons: !_isEditing
            ? null
            : <Widget>[
                widget.cellEditingAction == CupertinoEditingAction.select
                    ? NativeToolBar(
                        height: 35.0,
                        leading: NativeTextButton(
                          label: "Select All",
                          onPressed: _items != null && _items.isNotEmpty
                              ? () => _selectAll()
                              : null,
                        ),
                        trailing: NativeTextButton(
                          label: "Delete",
                          onPressed:
                              selectedItems != null && selectedItems.isNotEmpty
                                  ? () => _deleteAll()
                                  : null,
                        ),
                      )
                    : NativeToolBar(
                        height: 35.0,
                        leading: NativeTextButton(
                          label: "Delete All",
                          onPressed: _items != null && _items.isNotEmpty
                              ? () {
                                  _selectAll();
                                  _deleteAll();
                                }
                              : null,
                        ),
                      ),
              ],
      ),
    );
  }

// Widget _buildCell(BuildContext context,
//     {@required CupertinoTableCell<dynamic> cell,
//     bool lastItem = true,
//     int index = 0}) {
//   Widget _child;
//   // NativeListTile _item = cell?.data as NativeListTile;

//   final CupertinoListTileData _ios = CupertinoListTileData(
//     hideLeadingIcon: true,
//     style: CupertinoCellStyle.custom,
//     accessory: widget.cellAccessory,
//     editingAction: widget.cellEditingAction,
//     editingAccessory: widget.cellEditingAccessory,
//     padding: null,
//     editingAccessoryTap: () {
//       if (widget?.onCellTap != null)
//         widget.onCellEditingAccessoryTap(cell?.data);
//     },
//     accessoryTap: () {
//       if (widget?.onCellTap != null) widget.onCellAccessoryTap(cell?.data);
//     },
//     editingActionTap: () {
//       if (widget.cellEditingAction == CupertinoEditingAction.remove) {
//         _removeCell(cell);
//       } else if (widget.cellEditingAction == CupertinoEditingAction.select) {
//         setState(() {
//           cell.selected = !cell.selected;
//         });
//         _updateSelectedItems();
//       }
//     },
//   );

//   if (widget.cellEditingAction == CupertinoEditingAction.select) {
//     _child = GestureDetector(
//       onTapDown: (TapDownDetails details) {
//         if (!_isEditing) {
//           print("On Tap Down..");
//           setState(() {
//             cell.selected = true;
//           });
//         }
//       },
//       onTapCancel: () {
//         if (!_isEditing) {
//           print("On Tap Cancel..");
//           setState(() {
//             cell.selected = false;
//           });
//         }
//       },
//       child: NativeListTile(
//         editing: _isEditing,
//         selected: cell.selected,
//         child: cell?.data,
//         ios: _ios,
//         lastItem: lastItem,
//         onTap: () {
//           if (!_isEditing) {
//             print("Item Tapped...");
//             setState(() {
//               cell.selected = false;
//             });
//             if (widget?.onCellTap != null) widget.onCellTap(cell?.data);
//           } else {
//             print("On Tap Down..");
//             setState(() {
//               cell.selected = !cell.selected;
//             });
//             _updateSelectedItems();
//           }
//         },
//       ),
//     );
//   } else {
//     _child = GestureDetector(
//       onTapDown: (TapDownDetails details) {
//         if (!_isEditing) {
//           setState(() {
//             cell.selected = true;
//           });
//         }
//       },
//       onTapCancel: () {
//         if (!_isEditing) {
//           setState(() {
//             cell.selected = false;
//           });
//         }
//       },
//       child: NativeListTile(
//         editing: _isEditing,
//         selected: cell.selected,
//         child: cell?.data,
//         ios: _ios,
//         lastItem: lastItem,
//         onTap: () {
//           if (!_isEditing) {
//             print("Item Tapped...");
//             setState(() {
//               cell.selected = false;
//             });
//             if (widget?.onCellTap != null) widget.onCellTap(cell?.data);
//           }
//         },
//       ),
//     );
//   }

//   final List<Widget> _trailingActions = <Widget>[];

//   if (widget?.trailingActions != null) {
//     _trailingActions..addAll(widget.trailingActions);
//   }

//   _trailingActions.add(
//     new IconSlideAction(
//       caption: 'Delete',
//       color: Colors.red,
//       icon: Icons.delete,
//       onTap: () => _removeCell(cell),
//     ),
//   );

//   return Slidable(
//     key: Key(index.toString()),
//     controller: slidableController,
//     slideToDismissDelegate: new SlideToDismissDrawerDelegate(
//       onDismissed: (SlideActionType actionType) {
//         _removeCell(cell);
//       },
//     ),
//     delegate: new SlidableScrollDelegate(),
//     actionExtentRatio: 0.25,
//     child: _child,
//     actions: widget?.leadingActions,
//     secondaryActions: _trailingActions,
//   );
// }

  void _removeCell(CupertinoTableCell cell) {
    if (_items.contains(cell)) {
      setState(() {
        _items.remove(cell);
      });
      print("Removed Item... ${cell?.id}");
    }
  }
}
