part of native_widgets;

// class NativeNavigator {
//   Future<dynamic> push<T>(BuildContext context,
//       {@required String title, @required Widget page}) async {
//     return await Navigator.of(context).push<T>(NativeRoute<T>(
//       title: title,
//       builder: (BuildContext context) => page,
//     ));
//   }

//   void pop<T>(BuildContext context) async {
//     Navigator.of(context).pop<T>();
//   }
// }

Route<T> NativeRoute<T>({
  @required String title,
  bool fullscreenDialog = false,
  Function(BuildContext) builder,
  bool maintainState = false,
  RouteSettings settings,
}) {
  if (Platform.isIOS || Platform.isMacOS) {
    return CupertinoPageRoute<T>(
      title: title ?? "",
      builder: builder,
      fullscreenDialog: fullscreenDialog,
      maintainState: maintainState,
      settings: settings,
    );
  }

  return MaterialPageRoute<T>(
    builder: builder,
    fullscreenDialog: fullscreenDialog,
    maintainState: maintainState,
    settings: settings,
  );
}
