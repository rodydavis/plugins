part of native_widgets;

// Native Dialog Action for Native Dialog
class NativeDialogAction {
  final String text;
  final bool isDestructive;
  final VoidCallback onPressed;

  NativeDialogAction(
      {@required this.text, this.isDestructive, @required this.onPressed});
}

// Native Dialog
class NativeDialog extends StatefulWidget {
  final String title;
  final String content;
  final TextStyle textStyle;
  final List<NativeDialogAction> actions;
  final bool showMaterial;

  NativeDialog({
    @required this.actions,
    this.title,
    @required this.content,
    this.textStyle,
    this.showMaterial = false,
  });

  @override
  _NativeDialogState createState() => _NativeDialogState();
}

class _NativeDialogState extends State<NativeDialog> {
  @override
  Widget build(BuildContext context) {
    final bool _isIos = showCupertino(showMaterial: widget.showMaterial);

    if (_isIos) {
      return CupertinoAlertDialog(
          title: widget.title == null
              ? null
              : Text(
                  widget.title,
                  style: widget.textStyle,
                ),
          content: Text(
            widget.content,
            style: widget.textStyle,
          ),
          actions: widget.actions
              .map((NativeDialogAction item) => CupertinoDialogAction(
                    child: Text(item.text),
                    isDestructiveAction: item.isDestructive,
                    onPressed: Feedback.wrapForTap(item.onPressed, context),
                  ))
              .toList());
    }

    return AlertDialog(
        title: widget.title == null
            ? null
            : Text(
                widget.title,
                style: widget.textStyle,
              ),
        content: Text(
          widget.content,
          style: widget.textStyle,
        ),
        actions: widget.actions
            .map((NativeDialogAction item) => FlatButton(
                  child: Text(
                    item.text,
                    style: TextStyle(
                        color: item.isDestructive ? Colors.redAccent : null),
                  ),
                  onPressed: item.onPressed,
                ))
            .toList());
  }
}
