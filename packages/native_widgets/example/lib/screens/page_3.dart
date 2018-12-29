import 'package:flutter/material.dart';
import 'details/details_1.dart';

import 'package:native_widgets/native_widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Page3 extends StatefulWidget {
  @override
  Page3State createState() {
    return new Page3State();
  }
}

class Page3State extends State<Page3> {
  // List<NativeListTile> _sectionA, _sectionB, _sectionC;

  bool _isEditing = false;
  bool _isSearching = false;

  @override
  void initState() {
    // _init();
    super.initState();
  }

  final Map<int, Widget> children = const <int, Widget>{
    0: Text('Midnight'),
    1: Text('Viridian'),
    2: Text('Cerulean'),
  };
  int sharedValue = 0;

  final List<dynamic> selected = <dynamic>[];

  @override
  Widget build(BuildContext context) {
    final _sectionA = contacts.getRange(0, 10).toList();
    final _sectionB = contacts.getRange(11, 20).toList();
    final _sectionC = contacts.getRange(21, 30).toList();

    final _sections = _buildSections(context);

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
      // sections: [
      //   NativeListViewSection.builder(
      //     header: Text("A",
      //         style: TextStyle(
      //           fontWeight: FontWeight.bold,
      //         )),
      //     itemBuilder: (BuildContext context, int index) {
      //       final _item = _sectionA[index];
      //       return _buildListTile(context, _item);
      //     },
      //     itemCount: _sectionA?.length ?? 0,
      //   ),
      //   NativeListViewSection.builder(
      //     header: Text("B",
      //         style: TextStyle(
      //           fontWeight: FontWeight.bold,
      //         )),
      //     itemBuilder: (BuildContext context, int index) {
      //       final _item = _sectionB[index];
      //       return _buildListTile(context, _item);
      //     },
      //     itemCount: _sectionB?.length ?? 0,
      //   ),
      //   NativeListViewSection.builder(
      //     header: Text("C",
      //         style: TextStyle(
      //           fontWeight: FontWeight.bold,
      //         )),
      //     itemBuilder: (BuildContext context, int index) {
      //       final _item = _sectionC[index];
      //       return _buildListTile(context, _item);
      //     },
      //     itemCount: _sectionC?.length ?? 0,
      //   ),
      // ],
      sections: _sections ?? [],
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

  List<NativeListViewSection> _buildSections(BuildContext context) {
    contacts.sort((a, b) {
      return a[0].toLowerCase().compareTo(b[0].toLowerCase());
    });

    List<NativeListViewSection> sections = [];

    var map = Map<String, dynamic>();

    for (List<String> _contact in contacts) {
      final String _letter = _contact[0].substring(0, 1).toUpperCase();
      map[_letter] = <dynamic>[];
    }

    print(map.keys);

    for (List<String> _contact in contacts) {
      final String _letter = _contact[0].substring(0, 1).toUpperCase();
      map[_letter].add(_contact);
    }

    for (String _key in map.keys) {
      sections.add(NativeListViewSection.builder(
        header: Text(_key,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        itemBuilder: (BuildContext context, int index) {
          return _buildListTile(context, map[_key][index]);
        },
        itemCount: map[_key]?.length ?? 0,
      ));
    }

    return sections;
  }

  Widget _buildListTile(BuildContext context, List<String> item) {
    final bool _selected = selected?.contains(item) ?? false;

    return new Slidable(
      key: Key(item[0]),
      delegate: new SlidableDrawerDelegate(),
      slideToDismissDelegate: new SlideToDismissDrawerDelegate(
        onDismissed: (actionType) {
          setState(() {
            contacts.remove(item);
          });
        },
      ),
      actionExtentRatio: 0.25,
      closeOnScroll: true,
      child: NativeListTile(
        selected: _selected,
        editing: _isEditing,
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
      ),
      // actions: <Widget>[
      //   new IconSlideAction(
      //     caption: 'Archive',
      //     color: Colors.blue,
      //     icon: Icons.archive,
      //     onTap: () {},
      //   ),
      //   new IconSlideAction(
      //     caption: 'Share',
      //     color: Colors.indigo,
      //     icon: Icons.share,
      //     onTap: () {},
      //   ),
      // ],
      secondaryActions: <Widget>[
        // new IconSlideAction(
        //   caption: 'More',
        //   color: Colors.black45,
        //   icon: Icons.more_horiz,
        //   onTap: () {},
        // ),
        new IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            setState(() {
              contacts.remove(item);
            });
          },
        ),
      ],
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
