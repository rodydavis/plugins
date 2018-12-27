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
  });

  final bool editing, selected;
  final Widget child;
  final CupertinoEditingAction editingAction;
  final CupertinoEditingAccessory editingAccessory;
  final CupertinoAccessory accessory;
  final VoidCallback accessoryTap;
  final VoidCallback onTap, onLongPressed;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgets = <Widget>[];

    if (editing) {
      if (editingAccessory != null)
        switch (editingAccessory) {
          case CupertinoEditingAccessory.disclosureIndicator:
            _widgets..add(const Icon(CupertinoIcons.right_chevron));
            break;
          case CupertinoEditingAccessory.detailDisclosure:
            _widgets
              ..addAll([
                const Icon(CupertinoIcons.info),
                const Icon(CupertinoIcons.right_chevron),
              ]);
            break;
          case CupertinoEditingAccessory.detail:
            _widgets..add(const Icon(CupertinoIcons.info));
            break;
          case CupertinoEditingAccessory.checkmark:
            _widgets..add(const Icon(CupertinoIcons.check_mark));
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

    final Widget row = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      onLongPress: onLongPressed,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          color: selected ? Colors.grey[400] : Colors.transparent,
          padding: const EdgeInsets.only(top: 9.0),
          child: Row(
            children: <Widget>[
              Container(
                padding: editing ? const EdgeInsets.only(left: 12.0) : null,
                child: editing
                    ? Container(
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
                          onPressed: () {},
                        ),
                      )
                    : null,
              ),
              Expanded(child: child),
            ]..addAll(_widgets ?? []),
          ),
        ),
      ),
    );

    return row;
  }
}
