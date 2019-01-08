part of native_widgets;

// class NativeToolbar extends StatelessWidget {
//   final List<Widget> buttons;

//   NativeToolbar({this.buttons});

//   @override
//   Widget build(BuildContext context) {
//     return new Container(
// //      height: 48.0,
//       child: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         child:
//             buttons == null ? Container(height: 25.0) : Row(children: buttons),
//       ),
//     );
//   }
// }

class NativeToolBar extends StatelessWidget {
  final Widget leading, trailing, middle;
  final double height;

  NativeToolBar({
    this.leading,
    this.trailing,
    this.middle,
    this.height = 25.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width - 20,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          leading ?? Container(),
          middle ?? Container(),
          trailing ?? Container(),
        ],
      ),
    );
  }
}
