import 'package:native_widgets/native_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

typedef ItemWidgetBuilder = Widget Function(
    BuildContext context, dynamic item, bool tablet);
typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index);

class CupertinoMasterDetailController extends StatelessWidget {
  final ItemWidgetBuilder detailBuilder;
  final IndexedWidgetBuilder itemBuilder;
  final Widget onNull, onEmpty, appBar;
  final dynamic selectedItem;
  final ValueChanged<dynamic> itemSelected;
  final List<dynamic> items;

  CupertinoMasterDetailController({
    @required this.detailBuilder,
    @required this.selectedItem,
    @required this.itemSelected,
    @required this.itemBuilder,
    @required this.items,
    this.appBar,
    this.onNull,
    this.onEmpty,
  });

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: _ItemListing(
        onEmpty: onEmpty,
        onNull: onNull,
        itemBuilder: itemBuilder,
        items: items,
        selectedItem: selectedItem,
        itemSelectedCallback: (item) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => detailBuilder(context, item, false)),
          );
        },
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Scaffold(
            appBar: appBar,
            body: _ItemListing(
              onEmpty: onEmpty,
              onNull: onNull,
              itemBuilder: itemBuilder,
              items: items,
              selectedItem: selectedItem,
              itemSelectedCallback: itemSelected,
            ),
          ),
        ),
        Container(
          width: 1.0,
          color: Colors.grey[300],
        ),
        Flexible(
          flex: 3,
          child: detailBuilder(context, selectedItem, true),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobileLayout = shortestSide < 600;

    if (useMobileLayout) {
      return _buildMobileLayout(context);
    }

    return _buildTabletLayout(context);
  }
}

class _ItemListing extends StatelessWidget {
  _ItemListing({
    @required this.itemSelectedCallback,
    this.selectedItem,
    this.itemBuilder,
    this.items,
    this.onNull,
    this.onEmpty,
  });

  final ValueChanged<dynamic> itemSelectedCallback;
  final dynamic selectedItem;
  final IndexedWidgetBuilder itemBuilder;
  final List<dynamic> items;
  final Widget onNull, onEmpty;

  @override
  Widget build(BuildContext context) {
    if (items == null) {
      return onNull ?? Center(child: CircularProgressIndicator());
    }

    if (items.isEmpty) {
      return onEmpty ?? Center(child: Text("No Items Found"));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final _child = itemBuilder(context, index);
        return GestureDetector(
          onTap: () => itemSelectedCallback(items[index]),
          child: _child,
        );
      },
    );
  }
}
