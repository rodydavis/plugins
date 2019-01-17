part of native_widgets;

Future<T> showNativeDialog<T>({
  @required BuildContext context,
  @required NativeDialog<T> child,
}) {
  if (Platform.isIOS) {
    if (child?.ios?.showActionSheet ?? false) {
      return showCupertinoModalPopup<T>(
        context: context,
        builder: (BuildContext context) => child,
      );
    } else {
      return showCupertinoDialog<T>(
        context: context,
        builder: (BuildContext context) => child,
      );
    }
  }
  return showDialog<T>(
    context: context,
    builder: (BuildContext context) => child,
  );
}

// Native Dialog
class NativeDialog<T> extends StatelessWidget {
  final Text title;
  final Text content;
  final List<NativeDialogAction> actions;
  final CupertinoDialogData ios;

  const NativeDialog({
    Key key,
    @required this.actions,
    this.title,
    @required this.content,
    this.ios,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
        key: key,
        ios: (BuildContext context) {
          if (ios?.showActionSheet ?? false || actions.length > 3) {
            NativeDialogAction _toRemove;
            for (NativeDialogAction item in actions) {
              if (actions.contains(item?.removeInActionSheet ?? false)) {
                _toRemove = item;
              }
            }
            if (_toRemove != null) actions.remove(_toRemove);
            return CupertinoActionSheet(
              title: title,
              message: content,
              actions: actions
                  .map((NativeDialogAction item) => CupertinoActionSheetAction(
                        child: item.text,
                        isDestructiveAction: item.isDestructive,
                        onPressed: Feedback.wrapForTap(item.onPressed, context),
                      ))
                  .toList(),
              cancelButton: ios?.cancelButton ??
                  CupertinoActionSheetAction(
                    child: const Text('Cancel'),
                    isDefaultAction: true,
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                    },
                  ),
            );
          }

          // actions.add(cancelAction);
          return CupertinoAlertDialog(
              title: title,
              content: content,
              actions: actions
                  .map((NativeDialogAction item) => CupertinoDialogAction(
                        child: item.text,
                        isDestructiveAction: item.isDestructive,
                        onPressed: Feedback.wrapForTap(item.onPressed, context),
                      ))
                  .toList());
        },
        android: (BuildContext context) {
          // actions.add(cancelAction);
          return AlertDialog(
              title: title,
              content: content,
              actions: actions
                  .map((NativeDialogAction item) => FlatButton(
                        child: Text(
                          item.text?.data,
                          style: TextStyle(
                              color:
                                  item.isDestructive ? Colors.redAccent : null),
                        ),
                        onPressed: item.onPressed,
                      ))
                  .toList());
        });
  }
}

// Native Dialog Action for Native Dialog
class NativeDialogAction {
  final Text text;
  final bool isDestructive, removeInActionSheet;
  final VoidCallback onPressed;

  const NativeDialogAction({
    @required this.text,
    this.isDestructive,
    @required this.onPressed,
    this.removeInActionSheet = false,
  });
}

class CupertinoDialogData {
  final bool showActionSheet;
  final CupertinoActionSheetAction cancelButton;

  const CupertinoDialogData({
    this.showActionSheet = false,
    this.cancelButton,
  });
}
