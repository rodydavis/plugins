import 'package:flutter/material.dart';
import 'details/details_1.dart';

import 'package:native_widgets/native_widgets.dart';

class Page3 extends StatefulWidget {
  @override
  Page3State createState() {
    return new Page3State();
  }
}

class Page3State extends State<Page3> {
  // List<NativeListTile> _items, _filtered;

  bool _isEditing = false;
  bool _isSearching = false;

  @override
  void initState() {
    // _items = [];
    // _init();
    super.initState();
  }

  // void _init({bool force = false}) {
  //   if (force) {
  //     setState(() {
  //       _items?.clear();
  //     });
  //   }
  //   setState(() {
  //     _items = contacts.map((var item) {
  //       return NativeListTile(
  //         editing: _isEditing,
  //         avatar: Container(
  //           height: 60.0,
  //           width: 60.0,
  //           decoration: BoxDecoration(
  //             color: Colors.lightBlue,
  //             borderRadius: BorderRadius.circular(8.0),
  //           ),
  //         ),
  //         leading: NativeIcon(
  //           Icons.phone,
  //           iosIcon: CupertinoIcons.phone_solid,
  //         ),
  //         title: Text(item[0]),
  //         subtitle: Text(item[1]),
  //         trailing: <Widget>[
  //           NativeText(item[2], type: NativeTextTheme.detail),
  //         ],
  //         ios: CupertinoListTileData(
  //           hideLeadingIcon: true,
  //           style: CupertinoCellStyle.subtitle,
  //           // accessory: CupertinoAccessory.detailDisclosure,
  //           // editingAction: CupertinoEditingAction.select,
  //           // editingAccessory: CupertinoEditingAccessory.detail,
  //           // editingAccessoryTap: () {
  //           //   print("Editing Detail Tapped");
  //           // },
  //           // accessoryTap: () {
  //           //   print("Accessory Detail Tapped");
  //           // },
  //         ),
  //         // onTap: () {},
  //       );
  //     }).toList();
  //     _filtered = _items;
  //   });
  // }

  final Map<int, Widget> children = const <int, Widget>{
    0: Text('Midnight'),
    1: Text('Viridian'),
    2: Text('Cerulean'),
  };
  int sharedValue = 0;

  final List<dynamic> selected = <dynamic>[];

  @override
  Widget build(BuildContext context) {
    final _items = contacts.map((List<String> item) {
      final bool _selected = selected?.contains(item) ?? false;
      return NativeListTile(
        editing: _isEditing,
        selected: _selected,
        avatar: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        leading: NativeIcon(
          Icons.phone,
          iosIcon: CupertinoIcons.phone_solid,
        ),
        title: Text(item[0]),
        subtitle: Text(item[1]),
        trailing: <Widget>[
          NativeText(item[2], type: NativeTextTheme.detail),
        ],
        onTap: () {
          if (_isEditing) {
            if (_selected) {
              setState(() {
                selected.remove(item);
              });
            } else {
              setState(() {
                selected.add(item);
              });
            }
          }
        },
        ios: CupertinoListTileData(
          hideLeadingIcon: true,
          style: CupertinoCellStyle.subtitle,
          accessory: CupertinoAccessory.detailDisclosure,
          editingAction: CupertinoEditingAction.select,
          editingAccessory: CupertinoEditingAccessory.detail,
          editingAccessoryTap: () {
            print("Editing Detail Tapped");
          },
          accessoryTap: () {
            print("Accessory Detail Tapped");
          },
        ),
        // onTap: () {},
      );
    }).toList();

    return NativeListViewScaffold(
      trailing: NativeIconButton(
        icon: Icon(Icons.add),
        iosIcon: Icon(
          CupertinoIcons.add,
          color: CupertinoColors.activeBlue,
          size: 30.0,
        ),
        onPressed: () {},
      ),
      sections: [
        NativeListViewSection(
          header: Text("A",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          children: _items.getRange(0, 10).toList(),
        ),
        NativeListViewSection(
          header: Text("B",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          children: _items.getRange(11, 20).toList(),
        ),
        NativeListViewSection(
          header: Text("C",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          children: _items.getRange(21, 30).toList(),
        ),
      ],
      widgets: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 8.0),
          child: CupertinoSegmentedControl<int>(
            children: children,
            onValueChanged: (int newValue) {
              setState(() {
                sharedValue = newValue;
              });
            },
            groupValue: sharedValue,
          ),
        ),
        Divider(),
      ],
      onRefresh: () async {
        await Future<void>.delayed(Duration(seconds: 1));
        return;
      },
      selectedItemsChanged: (List<dynamic> selected) {
        print(selected);
      },
      onCellTap: (dynamic item) {
        if (item != null) {
          print(item?.title?.data);
        }
        Navigator.push<dynamic>(
            context,
            NativeRoute<dynamic>(
                builder: (BuildContext context) => DetailsScreen()));
      },
      isEditing: _isEditing,
      onEditing: (bool value) {
        if (value != null) {
          setState(() {
            _isEditing = value;
          });
        }
      },
      isSearching: _isSearching,
      onSearch: (bool value) {
        if (value != null) {
          setState(() {
            _isSearching = value;
          });
          print("Search: $value");
        }
      },
      ios: CupertinoListViewData(
        showEditingButtonLeft: true,
      ),
    );
  }
}

List<List<String>> contacts = <List<String>>[
  <String>['George Washington', 'Westmoreland County', ' 4/30/1789'],
  <String>['John Adams', 'Braintree', ' 3/4/1797'],
  <String>['Thomas Jefferson', 'Shadwell', ' 3/4/1801'],
  <String>['James Madison', 'Port Conway', ' 3/4/1809'],
  <String>['James Monroe', 'Monroe Hall', ' 3/4/1817'],
  <String>['Andrew Jackson', 'Waxhaws Region South/North', ' 3/4/1829'],
  <String>['John Quincy Adams', 'Braintree', ' 3/4/1825'],
  <String>['William Henry Harrison', 'Charles City County', ' 3/4/1841'],
  <String>['Martin Van Buren', 'Kinderhook New', ' 3/4/1837'],
  <String>['Zachary Taylor', 'Barboursville', ' 3/4/1849'],
  <String>['John Tyler', 'Charles City County', ' 4/4/1841'],
  <String>['James Buchanan', 'Cove Gap', ' 3/4/1857'],
  <String>['James K. Polk', 'Pineville North', ' 3/4/1845'],
  <String>['Millard Fillmore', 'Summerhill New', '7/9/1850'],
  <String>['Franklin Pierce', 'Hillsborough New', ' 3/4/1853'],
  <String>['Andrew Johnson', 'Raleigh North', ' 4/15/1865'],
  <String>['Abraham Lincoln', 'Sinking Spring', ' 3/4/1861'],
  <String>['Ulysses S. Grant', 'Point Pleasant', ' 3/4/1869'],
  <String>['Rutherford B. Hayes', 'Delaware', ' 3/4/1877'],
  <String>['Chester A. Arthur', 'Fairfield', ' 9/19/1881'],
  <String>['James A. Garfield', 'Moreland Hills', ' 3/4/1881'],
  <String>['Benjamin Harrison', 'North Bend', ' 3/4/1889'],
  <String>['Grover Cleveland', 'Caldwell New', ' 3/4/1885'],
  <String>['William McKinley', 'Niles', ' 3/4/1897'],
  <String>['Woodrow Wilson', 'Staunton', ' 3/4/1913'],
  <String>['William H. Taft', 'Cincinnati', ' 3/4/1909'],
  <String>['Theodore Roosevelt', 'New York City New', ' 9/14/1901'],
  <String>['Warren G. Harding', 'Blooming Grove', ' 3/4/1921'],
  <String>['Calvin Coolidge', 'Plymouth', '8/2/1923'],
  <String>['Herbert Hoover', 'West Branch', ' 3/4/1929'],
  <String>['Franklin D. Roosevelt', 'Hyde Park New', ' 3/4/1933'],
  <String>['Harry S. Truman', 'Lamar', ' 4/12/1945'],
  <String>['Dwight D. Eisenhower', 'Denison', ' 1/20/1953'],
  <String>['Lyndon B. Johnson', 'Stonewall', '11/22/1963'],
  <String>['Ronald Reagan', 'Tampico', ' 1/20/1981'],
  <String>['Richard Nixon', 'Yorba Linda', ' 1/20/1969'],
  <String>['Gerald Ford', 'Omaha', 'August 9/1974'],
  <String>['John F. Kennedy', 'Brookline', ' 1/20/1961'],
  <String>['George H. W. Bush', 'Milton', ' 1/20/1989'],
  <String>['Jimmy Carter', 'Plains', ' 1/20/1977'],
  <String>['George W. Bush', 'New Haven', ' 1/20, 2001'],
  <String>['Bill Clinton', 'Hope', ' 1/20/1993'],
  <String>['Barack Obama', 'Honolulu', ' 1/20/2009'],
  <String>['Donald J. Trump', 'New York City', ' 1/20/2017'],
];
