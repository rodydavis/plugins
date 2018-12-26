part of native_widgets;

class NativeListTile extends StatelessWidget {
  final Text subtitle, title;
  final Widget avatar, child;
  final List<Widget> trailing;
  final NativeIcon leading;
  final MaterialListTileData android;
  final CupertinoListTileData ios;
  final VoidCallback onTap, onLongPressed;
  final bool lastItem, selected, hideLeadingIcon, singleLine;

  NativeListTile({
    @required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.android,
    this.avatar,
    this.onTap,
    this.onLongPressed,
    this.ios,
    this.child,
    this.lastItem = false,
    this.selected = false,
    this.hideLeadingIcon = true,
    this.singleLine = false,
  });

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
        if (ios?.showTrailingDisclosureIndicator != null &&
            ios.showTrailingDisclosureIndicator) {
          trailing..add(const Icon(CupertinoIcons.right_chevron));
        }

        if (avatar != null && !singleLine) {
          return CupertinoAvatarListTile(
            onTap: onTap,
            onLongPressed: onLongPressed,
            avatar: avatar,
            lastItem: lastItem,
            title: title?.data,
            subtitle: subtitle?.data,
            actions: trailing,
            selected: selected,
          );
        }

        if (!singleLine) {
          return CupertinoPhoneListTile(
            onTap: onTap,
            onLongPressed: onLongPressed,
            title: title?.data,
            subtitle: subtitle?.data,
            actions: trailing,
            icon: leading,
            hideLeadingIcon: hideLeadingIcon,
            lastItem: lastItem,
            selected: selected,
          );
        }

        if (subtitle != null) {
          return CupertinoTextMenu(
            children: <Widget>[title, subtitle],
          );
        }

        if (trailing != null) {
          return CupertinoTextMenu(
            children: <Widget>[title]..addAll(trailing ?? []),
          );
        }

        if (title != null) {
          return CupertinoTextMenu(
            children: <Widget>[title],
          );
        }

        return child;
      },
    );
  }
}

class MaterialListTileData {}

class CupertinoListTileData {
  final bool showTrailingDisclosureIndicator;

  CupertinoListTileData({
    this.showTrailingDisclosureIndicator = false,
  });
}
