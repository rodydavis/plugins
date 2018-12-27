part of native_widgets;

class NativeListTile extends StatelessWidget {
  final Text subtitle, title, id;
  final Widget avatar, child;
  final List<Widget> trailing;
  final NativeIcon leading;
  final MaterialListTileData android;
  final CupertinoListTileData ios;
  VoidCallback onTap, onLongPressed;
  bool selected, editing;
  final bool lastItem;

  NativeListTile({
    this.title,
    this.id,
    this.subtitle,
    this.leading,
    this.trailing,
    this.android,
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
    return PlatformWidget(
      android: (BuildContext context) {
        return ListTile(
          onTap: onTap,
          onLongPress: onLongPressed,
          leading: avatar ?? leading,
          title: title,
          subtitle: subtitle != null ? subtitle : null,
          trailing:
              trailing != null ? Row(children: trailing ?? <Widget>[]) : null,
        );
      },
      ios: (BuildContext context) {
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
      },
    );
  }
}

class MaterialListTileData {}

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
