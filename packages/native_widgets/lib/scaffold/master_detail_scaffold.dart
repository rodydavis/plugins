part of native_widgets;

class NativeMasterDetailScaffold extends StatelessWidget {
  final ItemWidgetBuilder detailBuilder;
  final IndexedWidgetBuilder itemBuilder;
  final Widget onNull, onEmpty, appBar;
  final dynamic selectedItem;
  final ValueChanged<dynamic> itemSelected;
  final List<dynamic> items;

  NativeMasterDetailScaffold({
    @required this.detailBuilder,
    @required this.selectedItem,
    @required this.itemSelected,
    @required this.itemBuilder,
    this.onNull,
    this.onEmpty,
    this.items,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoMasterDetailController(
      detailBuilder: detailBuilder,
      selectedItem: selectedItem,
      itemBuilder: itemBuilder,
      items: items,
      itemSelected: itemSelected,
      appBar: appBar,
    );
  }
}
