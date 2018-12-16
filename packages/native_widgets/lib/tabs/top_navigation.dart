part of native_widgets;

class NativeTopTabs extends StatelessWidget {
  final bool showMaterial;
  final Color selectedColor, borderColor, pressedColor;
  final ValueChanged<dynamic> onValueChanged;
  final dynamic groupValue;
  final List<Widget> tabs;

  NativeTopTabs({
    this.showMaterial = false,
    this.selectedColor,
    this.borderColor,
    this.pressedColor,
    this.onValueChanged,
    this.tabs,
    this.groupValue,
  });

  @override
  Widget build(BuildContext context) {
    final bool _isIos = showCupertino(showMaterial: showMaterial);
    final Map<int, Widget> iosTabs = const <int, Widget>{};

    int _index = 0;
    for (Widget item in tabs) {
      final Map<int, Widget> _tab = <int, Widget>{_index: item};
      iosTabs.addAll(_tab);
    }
    _index++;

    if (_isIos) {
      return CupertinoSegmentedControl<dynamic>(
        selectedColor: selectedColor,
        borderColor: borderColor,
        onValueChanged: onValueChanged,
        pressedColor: pressedColor,
        children: iosTabs,
        groupValue: groupValue,
      );
    }

    return TabBar(
      tabs: tabs,
    );
  }
}
