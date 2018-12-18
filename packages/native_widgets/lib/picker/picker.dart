part of native_widgets;

class NativePicker extends StatefulWidget {
  final Widget title;
  final Widget leading;
  final Widget trailing;
  final TextStyle style;
  final List<String> items;
  final ValueChanged<String> onSelection;
  final bool setFirstDefault;
  final String noneSelectedMessage;
  final String defaultItem;
  final bool showMaterial;

  NativePicker({
    this.leading,
    this.title,
    this.trailing,
    this.style,
    this.defaultItem,
    @required this.items,
    @required this.onSelection,
    this.setFirstDefault,
    this.noneSelectedMessage,
    this.showMaterial = false,
  });

  @override
  _NativePickerState createState() => _NativePickerState();
}

class _NativePickerState extends State<NativePicker> {
  double _kPickerSheetHeight = 216.0;
  double _kPickerItemHeight = 32.0;
  int _index = 0;
  String _selection = "";

  @override
  void initState() {
    super.initState();
    if (widget.setFirstDefault != null && widget.setFirstDefault) {
      setState(() {
        _selection = widget.items[_index];
        itemSelected(_selection);
      });
    } else if (widget.defaultItem != null && widget.defaultItem.isNotEmpty)
      setState(() {
        _selection = widget.defaultItem;
        itemSelected(_selection);
      });
  }

  void itemSelected(String selection) => widget.onSelection;

  Widget _buildPicker() {
    final FixedExtentScrollController scrollController =
        new FixedExtentScrollController(initialItem: _index);
    final bool _isIos = showCupertino(showMaterial: widget.showMaterial);

    if (_isIos) {
      return Container(
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
                onSelectedItemChanged: (int index) {
                  setState(() {
                    _index = index;
                    _selection = widget.items[_index];
                    itemSelected(_selection);
                  });
                },
                children:
                    new List<Widget>.generate(widget.items.length, (int index) {
                  return new Center(
                    child: new Text(
                      widget.items[index],
                      textScaleFactor: 1.0,
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      );
    }
    return DropdownButton<String>(
        value: _selection,
        items: widget.items
            .map(
              (String item) => DropdownMenuItem<String>(
                  value: item,
                  child: SizedBox(
                      width: 200.0,
                      child: Text(
                        item,
                        textScaleFactor: 1.0,
                        style: widget.style,
                      ))),
            )
            .toList(),
        onChanged: (String s) {
          setState(() {
            _selection = s;
            itemSelected(_selection);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final bool _isIos = showCupertino(showMaterial: widget.showMaterial);

    if (_isIos) {
      return ListTile(
        leading: widget.leading,
        title: widget.title,
        subtitle: widget.items == null
            ? null
            : Text(
                _selection == null || _selection.isEmpty
                    ? widget.noneSelectedMessage
                    : _selection,
                textScaleFactor: 1.0,
                style: widget.style,
              ),
        trailing: widget.trailing,
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return _buildPicker();
            },
          );
        },
      );
    }

    return ListTile(
      leading: widget.leading,
      title: widget.title,
      subtitle: widget.items == null ? null : _buildPicker(),
      trailing: widget.trailing,
    );
  }
}
