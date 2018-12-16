part of native_widgets;

// Native App Bar
class NativeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final Widget leading;
  final Widget title;
  final List<Widget> actions;

  // final TabBar bottom;

  NativeAppBar({
    Key key,
    this.foregroundColor,
    this.backgroundColor,
    this.leading,
    this.title,
    this.actions,
    this.preferredSize = const Size.fromHeight(56.0),
  });

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS
        ? CupertinoNavigationBar(
            middle: title,
            backgroundColor:
                backgroundColor == null ? Colors.transparent : backgroundColor,
            leading: leading,
            actionsForegroundColor: foregroundColor,
            trailing: actions == null
                ? null
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: actions.map((Widget item) => item).toList(),
                  ),
          )
        : AppBar(
            backgroundColor: backgroundColor,
            key: key,
            title: title,
            actions: actions,
            leading: leading,
          ));
  }
}
