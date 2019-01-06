import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';

class Page5 extends StatefulWidget {
  @override
  Page5State createState() {
    return new Page5State();
  }
}

class Page5State extends State<Page5> {
  List<String> _items = ["Test", "Hello", "World"];
  String _selectedItem;
  @override
  Widget build(BuildContext context) {
    return NativeMasterDetailScaffold(
      appBar: NativeAppBar(
        title: Text("Page 5"),
        ios: CupertinoNavigationBarData(
//          heroTag: "Details",
//          transitionBetweenRoutes: false,
            ),
      ),
      detailBuilder: (context, item, tablet) {
        if (tablet && item == null) {
          return Scaffold(
            body: Center(child: Text("No Item Selected")),
          );
        }
        final String _item = item;
        return Scaffold(
          appBar: tablet
              ? null
              : NativeAppBar(
                  title: Text("Details"),
                  ios: CupertinoNavigationBarData(
//                    heroTag: "Details",
//                    transitionBetweenRoutes: false,
                      ),
                ),
          body: Center(
            child: Text(_item),
          ),
        );
      },
      selectedItem: _selectedItem,
      itemSelected: (value) {
        setState(() {
          _selectedItem = value;
        });
      },
      itemBuilder: (BuildContext context, int index) {
        final _item = _items[index];
        return ListTile(
          title: Text(_item),
        );
      },
      items: _items,
    );
  }
}
