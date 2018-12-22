part of native_widgets;

class NativeSelection extends StatelessWidget {
  final bool showMaterial;
  final String value;
  final Widget noItemsLabel;
  final List<String> items;
  final ValueChanged<String> onChanged;

  NativeSelection({
    this.showMaterial = false,
    @required this.value,
    @required this.items,
    this.onChanged,
    this.noItemsLabel,
  });

  double _kPickerSheetHeight = 216.0;

  double _kPickerItemHeight = 32.0;
  // double textScaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    if (items == null || items.isEmpty) {
      return Container(
        child: noItemsLabel ?? const  Text( "No Items"),
      );
    }
    int _initialIndex = 0;
    int _index = 0;
    for (var _item in items) {
      if (_item == value) _initialIndex = _index;
      _index++;
    }

    final FixedExtentScrollController scrollController =
        new FixedExtentScrollController(initialItem: _initialIndex);
    if (Platform.isIOS && !showMaterial) {
      return new Container(
        height: _kPickerSheetHeight,
        color: CupertinoColors.white,
        child: new DefaultTextStyle(
          style: const TextStyle(
            color: CupertinoColors.black,
            fontSize: 22.0,
          ),
          child: new GestureDetector(
            // Blocks taps from propagating to the modal sheet and popping.
            onTap: () {},
            child: new SafeArea(
              child: new CupertinoPicker(
                scrollController: scrollController,
                itemExtent: _kPickerItemHeight,
                backgroundColor: CupertinoColors.white,
                onSelectedItemChanged: (int index) => onChanged(items[index]),
                children: new List<Widget>.generate(items.length, (int index) {
                  return new Center(
                      child: new Text(
                    items[index],
                    // textScaleFactor: textScaleFactor,
                    style: const TextStyle(color: Colors.black),
                  ));
                }),
              ),
            ),
          ),
        ),
      );
    }

    return DropdownButton<String>(
        value: value,
        items: items
            .map(
              (String item) => DropdownMenuItem<String>(
                  value: item,
                  child: SizedBox(
//                      width: 200.0,
                      child: Text(
                    item,
                    // textScaleFactor: textScaleFactor,
                  ))),
            )
            .toList(),
        onChanged: (s) => onChanged(s));
  }
}
