part of native_widgets;

class NativeToolbar extends StatelessWidget {
  final List<Widget> buttons;
  
  NativeToolbar({this.buttons});

  @override
  Widget build(BuildContext context) {
    return new Container(
//      height: 48.0,
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child:
            buttons == null ? Container(height: 25.0) : Row(children: buttons),
      ),
    );
  }
}
