import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'templates/avatar_tile.dart';
import 'templates/base_tile.dart';
import 'templates/basic_tile.dart';
import 'templates/phone_tile.dart';

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
    // CupertinoListTile _item = cell?.data as CupertinoListTile;

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
          child: CupertinoListTile(
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
          child: CupertinoListTile(
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
        _child = CupertinoListTile(
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

class CupertinoListTile extends StatelessWidget {
  final Text subtitle, title, id;
  final Widget avatar, child;
  final List<Widget> trailing;
  final IconData leading;
  final CupertinoListTileData ios;
  final VoidCallback onTap, onLongPressed;
  final bool selected, editing;
  final bool lastItem;

  CupertinoListTile({
    this.title,
    this.id,
    this.subtitle,
    this.leading,
    this.trailing,
    this.avatar,
    this.onTap,
    this.onLongPressed,
    this.ios,
    this.child,
    this.lastItem = true,
    this.selected = false,
    this.editing = false,
  });
  // : assert(ios?.style == CupertinoCellStyle.custom && child != null);

  @override
  Widget build(BuildContext context) {
    Widget _child = Container();

    switch (ios?.style) {
      case CupertinoCellStyle.avatarDetail:
        _child = CupertinoAvatarListTile(
          avatar: avatar,
          title: title?.data,
          subtitle: subtitle?.data,
          actions: trailing,
        );
        break;
      case CupertinoCellStyle.subtitle:
        _child = CupertinoPhoneListTile(
          title: title?.data,
          subtitle: subtitle?.data,
          actions: trailing,
          icon: leading,
          hideLeadingIcon: ios?.hideLeadingIcon,
        );
        break;
      case CupertinoCellStyle.basic:
        _child = CupertinoTextMenu(
          children: <Widget>[title]..addAll(trailing ?? []),
        );
        break;

      case CupertinoCellStyle.leftDetail:
        _child = Row(
          children: <Widget>[subtitle, title],
        );
        break;
      case CupertinoCellStyle.rightDetail:
        _child = CupertinoTextMenu(
          children: <Widget>[title, subtitle],
        );
        break;
      case CupertinoCellStyle.custom:
        _child = child ?? Container();
        break;
    }

    final Widget _row = CupertinoBaseTile(
      selected: selected,
      onTap: onTap,
      onLongPressed: onLongPressed,
      accessory: ios?.accessory,
      editing: editing,
      editingAccessory: ios?.editingAccessory,
      editingAction: ios?.editingAction,
      accessoryTap: ios?.accessoryTap,
      editingAccessoryTap: ios?.editingAccessoryTap,
      editingActionTap: ios?.editingActionTap,
      child: _child,
      padding: ios?.padding,
    );

    if (lastItem) {
      return _row;
    }

    return Column(
      children: <Widget>[
        _row,
        Container(
          height: 1.0,
          color: const Color(0xFFD9D9D9),
        ),
      ],
    );
  }
}

class CupertinoListTileData {
  final CupertinoCellStyle style;
  final CupertinoEditingAction editingAction;
  final CupertinoEditingAccessory editingAccessory;
  final CupertinoAccessory accessory;
  final VoidCallback accessoryTap, editingAccessoryTap, editingActionTap;
  final bool hideLeadingIcon, enableReorder;
  final EdgeInsets padding;

  CupertinoListTileData({
    this.style = CupertinoCellStyle.custom,
    this.accessory = CupertinoAccessory.none,
    this.editingAccessory = CupertinoEditingAccessory.none,
    this.editingAction = CupertinoEditingAction.remove,
    this.accessoryTap,
    this.hideLeadingIcon = false,
    this.enableReorder = true,
    this.editingAccessoryTap,
    this.editingActionTap,
    this.padding = const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
  });
}

enum CupertinoCellStyle {
  basic,
  rightDetail,
  leftDetail,
  subtitle,
  avatarDetail,
  custom,
}

enum CupertinoEditingAction {
  none,
  remove,
  select,
}

enum CupertinoAccessory {
  none,
  disclosureIndicator,
  detailDisclosure,
  checkmark,
  detail
}

enum CupertinoEditingAccessory {
  none,
  disclosureIndicator,
  detailDisclosure,
  checkmark,
  detail,
  dragHandle
}
