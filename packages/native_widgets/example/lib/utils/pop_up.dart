import 'package:native_widgets/native_widgets.dart';
import 'package:flutter/material.dart';

void showAlertPopup(BuildContext context, String title, String detail) async {
  void showSimpleDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) => child,
    );
  }

  return showSimpleDialog<void>(
      context: context,
      child: NativeDialog(
        title: title,
        content: detail,
        actions: <NativeDialogAction>[
          NativeDialogAction(
              text: 'Delete',
              isDestructive: true,
              onPressed: () {
                Navigator.pop(context);
              }),
          NativeDialogAction(
              text: 'Ok',
              isDestructive: false,
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ));
}
