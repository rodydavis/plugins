part of native_widgets;

class NativeGroupSelect<T> extends StatelessWidget {
  final ValueChanged<T> onValueChanged;
  final Map<T, Widget> children;
  final T groupValue;

  NativeGroupSelect({
    Key key,
    this.onValueChanged,
    @required this.groupValue,
    @required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      key: key,
      ios: (BuildContext context) {
        return CupertinoSegmentedControl<T>(
          children: children,
          onValueChanged: onValueChanged,
          groupValue: groupValue,
        );
      },
      android: (BuildContext context) {
        return Column(
            children: children.entries
                .map((MapEntry<T, Widget> item) => RadioListTile<T>(
                      title: item?.value,
                      value: item?.key,
                      groupValue: groupValue,
                      onChanged: onValueChanged,
                    ))
                .toList());
      },
    );
  }
}
