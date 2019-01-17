import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_controllers/cupertino_controllers.dart';
import '../details/screen.dart';

class MasterDetailScreen extends StatefulWidget {
  @override
  MasterDetailScreenState createState() {
    return new MasterDetailScreenState();
  }
}

class MasterDetailScreenState extends State<MasterDetailScreen> {
  List<String> _items = ["Test", "Hello", "World"];
  String _selectedItem;
  @override
  Widget build(BuildContext context) {
    return CupertinoMasterDetailController(
      appBar: CupertinoNavigationBar(
        middle: Text("Master Detail"),
      ),
      detailBuilder: (context, item, tablet) {
        if (tablet && item == null) {
          return Scaffold(
            body: Center(child: Text("No Item Selected")),
          );
        }
        final String _item = item;

        if (tablet) {
          return Scaffold(
            body: Center(
              child: Text(_item),
            ),
          );
        }

        return Scaffold(
          body: CustomScrollView(
            semanticChildCount: 2,
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
//            trailing: trailingButtons,
//            middle: Text("Presidents"),
                previousPageTitle: "Presidents",
                largeTitle: Text("Details"),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Text(_item),
                ),
              ),
            ],
          ),
        );
//        return DetailsScreen();
      },
      selectedItem: _selectedItem,
      itemSelected: (value) {
        setState(() {
          _selectedItem = value;
        });
      },
      itemBuilder: (BuildContext context, int index) {
        final _item = _items[index];
        return CupertinoListTile(
          title: Text(_item),
          subtitle: Text("Details"),
          ios: CupertinoListTileData(
            hideLeadingIcon: true,
            style: CupertinoCellStyle.subtitle,
            accessory: CupertinoAccessory.disclosureIndicator,
            editingAccessory: CupertinoEditingAccessory.detail,
            editingAccessoryTap: () {
              Navigator.push<dynamic>(
                  context,
                  CupertinoPageRoute<dynamic>(
                      title: "Details",
                      builder: (BuildContext context) => DetailsScreen()));
            },
          ),
        );
      },
      items: _items,
    );
  }
}
