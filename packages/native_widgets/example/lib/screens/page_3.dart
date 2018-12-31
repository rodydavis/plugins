import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:native_widgets/native_widgets.dart';

import 'details/details_1.dart';

class Page3 extends StatefulWidget {
  @override
  Page3State createState() {
    return new Page3State();
  }
}

class Page3State extends State<Page3> with SingleTickerProviderStateMixin {
  bool _isEditing = false;
  bool _isSearching = false;
  String _search = "";
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _focusNode.addListener(() {
      if (!_animationController.isAnimating) {
        _animationController.forward();
      }
    });
    super.initState();
  }

  final Map<int, Widget> children = const <int, Widget>{
    0: Text('Select'),
    1: Text('Remove'),
    2: Text('None'),
  };
  int sharedValue = 0;

  final List<dynamic> selected = <dynamic>[];

  void _removeItem(List<String> item) {
    setState(() {
      contacts.remove(item);
    });
  }

  List<Widget> _searchItems(BuildContext context, {String search = ""}) {
    final List<Widget> filtered = [];
    for (var _row in contacts) {
      bool _contains = false;
      if (_row[0].toLowerCase().trim().contains(search.toLowerCase().trim()))
        _contains = true;
      if (_row[1].toLowerCase().trim().contains(search.toLowerCase().trim()))
        _contains = true;
      if (_row[2].toLowerCase().trim().contains(search.toLowerCase().trim()))
        _contains = true;
      if (_contains) {
        filtered.add(_buildListTile(context, _row));
      }
    }
    return filtered ?? [];
  }

  @override
  Widget build(BuildContext context) {
    if (_isSearching) FocusScope.of(context).requestFocus(_focusNode);

    var _sections = _buildSections(context);

    if (_search != null && _search.isNotEmpty) {
      List<Widget> filtered = _searchItems(context, search: _search ?? "");

      _sections = [
        NativeListViewSection(
          header: null,
          children: filtered,
        )
      ];
    }

    return NativeListViewScaffold.sectioned(
      hideAppBarOnSearch: true,
      trailing: NativeIconButton(
        icon: Icon(Icons.add),
        iosIcon: Icon(
          CupertinoIcons.add,
          color: CupertinoColors.activeBlue,
          size: 30.0,
        ),
        onPressed: () {},
      ),
      sections: _sections ?? [],
      widgets: <Widget>[
        SafeArea(
          top: _isSearching,
          bottom: false,
          child: NativeSearchWidget(
            controller: _controller,
            focusNode: _focusNode,
            animation: _animation,
            onCancel: () {
              _controller.clear();
              _focusNode.unfocus();
              _animationController.reverse();
              setState(() {
                _search = "";
              });
            },
            onClear: () {
              _controller.clear();
              setState(() {
                _search = "";
              });
            },
            onChanged: (String value) {
              if (value != null)
                setState(() {
                  _search = value;
                });
            },
          ),
        ),
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
      isEditing: _isEditing,
      onEditing: (bool value) {
        if (value != null) {
          setState(() {
            _isEditing = value;
          });
          if (!_isEditing) {
            setState(() {
              selected.clear();
            });
          }
        }
      },
      isSearching: _isSearching,
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
    CupertinoEditingAction _action;
    switch (sharedValue) {
      case 0:
        _action = CupertinoEditingAction.select;
        break;
      case 1:
        _action = CupertinoEditingAction.remove;
        break;
      case 2:
        _action = CupertinoEditingAction.none;
        break;
      default:
    }
    return new Slidable(
      key: Key(item[0]),
      delegate: new SlidableDrawerDelegate(),
      slideToDismissDelegate: new SlideToDismissDrawerDelegate(
        onDismissed: (actionType) {
          _removeItem(item);
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
            if (_action == CupertinoEditingAction.select) {
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
          } else {
            Navigator.push<dynamic>(
                context,
                NativeRoute<dynamic>(
                    builder: (BuildContext context) => DetailsScreen()));
          }
        },
        ios: CupertinoListTileData(
            hideLeadingIcon: true,
            style: CupertinoCellStyle.subtitle,
            accessory: CupertinoAccessory.disclosureIndicator,
            editingAction: _action,
            editingAccessory: CupertinoEditingAccessory.detail,
            editingAccessoryTap: () {
              Navigator.push<dynamic>(
                  context,
                  NativeRoute<dynamic>(
                      builder: (BuildContext context) => DetailsScreen()));
            },
            editingActionTap: _action == CupertinoEditingAction.remove
                ? () => _removeItem(item)
                : null),

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
          onTap: () => _removeItem(item),
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
