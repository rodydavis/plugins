import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../native_widgets.dart';

class CupertinoBaseTile extends StatelessWidget {
  const CupertinoBaseTile({
    this.selected = false,
    this.editing = false,
    @required this.child,
    this.accessory = CupertinoAccessory.none,
    this.editingAccessory = CupertinoEditingAccessory.none,
    this.editingAction = CupertinoEditingAction.remove,
    this.accessoryTap,
    this.onLongPressed,
    this.onTap,
    this.editingAccessoryTap,
    this.editingActionTap,
  });

  final bool editing, selected;
  final Widget child;
  final CupertinoEditingAction editingAction;
  final CupertinoEditingAccessory editingAccessory;
  final CupertinoAccessory accessory;
  final VoidCallback accessoryTap, onTap, onLongPressed, editingAccessoryTap, editingActionTap;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgets = <Widget>[];

    if (editing) {
      if (editingAccessory != null)
        switch (editingAccessory) {
          case CupertinoEditingAccessory.disclosureIndicator:
            _widgets
              ..add(
                const Icon(CupertinoIcons.right_chevron),
              );
            break;
          case CupertinoEditingAccessory.detailDisclosure:
            _widgets
              ..addAll([
                IconButton(
                  icon: const Icon(CupertinoIcons.info,
                      color: CupertinoColors.activeBlue),
                  onPressed: editingAccessoryTap,
                ),
                const Icon(CupertinoIcons.right_chevron),
              ]);
            break;
          case CupertinoEditingAccessory.detail:
            _widgets
              ..add(
                IconButton(
                  icon: const Icon(CupertinoIcons.info,
                      color: CupertinoColors.activeBlue),
                  onPressed: editingAccessoryTap,
                ),
              );
            break;
          case CupertinoEditingAccessory.checkmark:
            _widgets
              ..add(
                const Icon(CupertinoIcons.check_mark),
              );
            break;
          case CupertinoEditingAccessory.dragHandle:
            _widgets
              ..add(IconButton(
                icon: const Icon(Icons.dehaze),
                onPressed: () {},
              ));
            break;
          case CupertinoEditingAccessory.none:
            break;
        }
    } else {
      if (accessory != null)
        switch (accessory) {
          case CupertinoAccessory.disclosureIndicator:
            _widgets..add(const Icon(CupertinoIcons.right_chevron));
            break;
          case CupertinoAccessory.detailDisclosure:
            _widgets
              ..addAll([
                NativeIconButton(
                  icon: const Icon(CupertinoIcons.info),
                  onPressed: accessoryTap,
                ),
                const Icon(CupertinoIcons.right_chevron),
              ]);
            break;
          case CupertinoAccessory.detail:
            _widgets
              ..add(NativeIconButton(
                icon: const Icon(CupertinoIcons.info),
                onPressed: accessoryTap,
              ));
            break;
          case CupertinoAccessory.checkmark:
            _widgets..add(const Icon(CupertinoIcons.check_mark));
            break;
          case CupertinoAccessory.none:
            break;
        }
    }

    Widget _editingAction;

    if (editingAction != null) {
      switch (editingAction) {
        case CupertinoEditingAction.remove:
          _editingAction = Container(
            height: 25.0,
            width: 25.0,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: NativeIconButton(
              icon: Icon(
                Icons.remove,
                color: CupertinoColors.white,
                // size: 18.0,
              ),
              onPressed: editingActionTap,
            ),
          );
          break;
        case CupertinoEditingAction.select:
          _editingAction = Container(
            height: 25.0,
            width: 25.0,
            decoration: selected
                ? BoxDecoration(
                    color: CupertinoColors.activeBlue,
                    borderRadius: BorderRadius.circular(25.0),
                  )
                : new BoxDecoration(
                    border: new Border.all(
                        color: CupertinoColors.lightBackgroundGray),
                    shape: BoxShape.circle),
            child: NativeIconButton(
              icon: Icon(
                CupertinoIcons.check_mark,
                color: selected ? CupertinoColors.white : Colors.transparent,
              ),
              onPressed: editingActionTap,
            ),
          );
          break;
        case CupertinoEditingAction.none:
          _editingAction = Container(
            height: 25.0,
            width: 25.0,
          );
          break;
      }
    }

    Color _rowColor = Colors.transparent;

    if (selected && editing) {
      _rowColor = Colors.lightBlue[50];
    }

    if (!editing && selected) {
      _rowColor = Colors.lightBlue[50];
    }

    final Widget row = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      onLongPress: onLongPressed,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          color: _rowColor,
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
          child: Row(
            children: <Widget>[
              Container(
                padding: editing ? const EdgeInsets.only(left: 12.0) : null,
                child: editing ? _editingAction : null,
              ),
              Expanded(child: child),
            ]..addAll(_widgets ?? <Widget>[]),
          ),
        ),
      ),
    );

    return row;
  }
}
