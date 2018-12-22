part of native_widgets;

class NativePicker extends StatelessWidget {
  final bool showMaterial;
  final String selection;
  final Widget label, noItemsLabel, leading, trailing;
  final List<String> items;
  final ValueChanged<String> onSelected;

  NativePicker({
    @required this.selection,
    @required this.items,
    this.showMaterial = false,
    this.onSelected,
    this.label,
    this.noItemsLabel,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS && !showMaterial) {
      return ListTile(
        leading: const Icon(Icons.label),
        title: label ?? const Text('Select an Item'),
        subtitle: Text(selection),
        trailing: items != null && items.length == 1
            ? NativeLoadingIndicator()
            : null,
        onTap: () async {
          await showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return NativeSelection(
                value: selection,
                items: items,
                onChanged: onSelected,
                noItemsLabel: noItemsLabel ?? const Text("No Items Found"),
              );
            },
          );
        },
      );
    }
    return ListTile(
      leading: leading,
      title: label ?? const Text('Select an Item'),
      subtitle: NativeSelection(
        showMaterial: showMaterial,
        value: selection,
        items: items,
        onChanged: onSelected,
        noItemsLabel: noItemsLabel ?? const Text("No Items Found"),
      ),
      trailing: trailing,
    );
  }
}
