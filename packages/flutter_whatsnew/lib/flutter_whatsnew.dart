library flutter_whatsnew;

import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';

class WhatsNewPage extends StatelessWidget {
  final Widget title;
  final Widget buttonText;
  final List<ListTile> items;
  final VoidCallback onButtonPressed;

  const WhatsNewPage({
    @required this.items,
    @required this.title,
    @required this.buttonText,
    this.onButtonPressed,
  });

  static void showDetailPopUp(
      BuildContext context, String title, String detail) async {
    void showDemoDialog<T>({BuildContext context, Widget child}) {
      showDialog<T>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => child,
      );
    }

    return showDemoDialog<Null>(
        context: context,
        child: NativeDialog(
          title: Text(title),
          content: Text(detail),
          actions: <NativeDialogAction>[
            NativeDialogAction(
                text: Text('OK'),
                isDestructive: false,
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ));
  }

  void show(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WhatsNewPage(
              title: title,
              buttonText: buttonText,
              items: items,
            ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        body: SafeArea(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Positioned(
            top: 10.0,
            left: 0.0,
            right: 0.0,
            child: title,
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 50.0,
            bottom: 80.0,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ListBody(
                  children: items
                      .map(
                        (ListTile item) => ListTile(
                              title: item.title,
                              subtitle: item.subtitle,
                              leading: item.leading,
                              trailing: item.trailing,
                              onTap: item.onTap,
                              onLongPress: item.onLongPress,
                            ),
                      )
                      .toList()),
            ),
          ),
          Positioned(
              bottom: 5.0,
              right: 10.0,
              left: 10.0,
              child: ListTile(
                title: NativeButton(
                  child: buttonText,
                  color: Colors.blue,
                  onPressed: onButtonPressed != null
                      ? onButtonPressed
                      : () {
                          Navigator.pop(context);
                        },
                ),
              )),
        ],
      ),
    )));
  }
}
