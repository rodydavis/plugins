import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../native_widgets.dart';

class CupertinoTableCell extends StatelessWidget {
  final bool selected;
  final bool editing;
  final bool canEdit;
  final bool canDelete;
  final bool lastItem;
  final Widget child;
  final String id;
  final VoidCallback onDelete, onTap;
  final SlidableController slideableController;
  final List<IconSlideAction> leadingActions, trailingActions;
  final ValueChanged<bool> onSelected;

  // -- Styling --
  final CupertinoAccessory accessory;
  final VoidCallback accessoryTap;
  final CupertinoEditingAction editingAction;
  final CupertinoEditingAccessory editingAccessory;
  final VoidCallback editingAccessoryTap;

  const CupertinoTableCell({
    Key key,
    this.selected = false,
    this.canEdit = true,
    this.canDelete = true,
    this.editing = false,
    this.lastItem = false,
    this.trailingActions,
    this.leadingActions,
    this.onTap,
    this.child,
    @required this.id,
    this.onDelete,
    this.onSelected,
    this.accessory = CupertinoAccessory.disclosureIndicator,
    this.accessoryTap,
    this.editingAccessoryTap,
    this.editingAccessory = CupertinoEditingAccessory.none,
    this.editingAction = CupertinoEditingAction.select,
    this.slideableController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _child;
    // NativeListTile _item = cell?.data as NativeListTile;

    final CupertinoListTileData _ios = CupertinoListTileData(
      hideLeadingIcon: true,
      style: CupertinoCellStyle.custom,
      accessory: accessory,
      editingAction: editingAction,
      editingAccessory: editingAccessory,
      padding: null,
      editingAccessoryTap: editingAccessoryTap,
      accessoryTap: accessoryTap,
      editingActionTap: () {
        switch (editingAction) {
          case CupertinoEditingAction.remove:
            onDelete();
            break;
          case CupertinoEditingAction.select:
            onSelected(!selected);
            break;
          default:
        }
      },
    );

    switch (editingAction) {
      case CupertinoEditingAction.select:
        _child = GestureDetector(
          onTapDown: (TapDownDetails details) {
            if (!editing) {
              print("On Tap Down..");
              onSelected(true);
            }
          },
          onTapCancel: () {
            if (!editing) {
              print("On Tap Cancel..");
              onSelected(false);
            }
          },
          child: NativeListTile(
            editing: editing,
            selected: selected,
            child: child,
            ios: _ios,
            lastItem: lastItem,
            onTap: () {
              if (!editing) {
                onSelected(false);
                onTap();
              } else {
                print("On Tap Down..");
                onSelected(!selected);
              }
            },
          ),
        );
        break;
      case CupertinoEditingAction.remove:
        _child = GestureDetector(
          onTapDown: (TapDownDetails details) {
            if (!editing) {
              onSelected(true);
            }
          },
          onTapCancel: () {
            if (!editing) {
              onSelected(false);
            }
          },
          child: NativeListTile(
            editing: editing,
            selected: selected,
            child: child,
            ios: _ios,
            lastItem: lastItem,
            onTap: () {
              if (!editing) {
                print("Item Tapped...");
                onSelected(false);
                onTap();
              }
            },
          ),
        );
        break;
      default:
        _child = NativeListTile(
          editing: editing,
          selected: selected,
          child: child,
          ios: _ios,
          lastItem: lastItem,
          onTap: () {
            if (!editing) {
              print("Item Tapped...");
              onSelected(false);
              onTap();
            }
          },
        );
    }

    final List<Widget> _trailingActions = <Widget>[];

    if (trailingActions != null) {
      _trailingActions..addAll(trailingActions);
    }

    _trailingActions.add(
      new IconSlideAction(
        caption: 'Delete',
        color: Colors.red,
        icon: Icons.delete,
        onTap: onDelete,
      ),
    );

    return Slidable(
      key: key,
      controller: slideableController,
      slideToDismissDelegate: new SlideToDismissDrawerDelegate(
        onDismissed: (SlideActionType actionType) {
          onDelete();
        },
      ),
      delegate: new SlidableScrollDelegate(),
      actionExtentRatio: 0.25,
      child: _child,
      actions: leadingActions,
      secondaryActions: _trailingActions,
    );
  }
}
