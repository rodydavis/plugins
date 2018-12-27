// Alphabetial Search on Side
// Editing Mode with Reorder and Delete
// Swipe to Delete Actions
// Sliver Lists

part of native_widgets;

/// iOS Table View Controller Functionality
class NativeListViewScaffold extends StatelessWidget {
  // Make Stateful for Editing, Refreshing, Searching
  final String title, previousTitle;
  final List<NativeListTile> items;
  final Widget trailing;
  // final Function(BuildContext context, int index) item;
  final VoidCallback viewDetails, onEditingComplete, onEditingStarted;
  final ValueChanged<dynamic> onItemTap;

  NativeListViewScaffold({
    // this.item,
    this.items,
    this.viewDetails,
    this.onEditingComplete,
    this.onEditingStarted,
    this.previousTitle,
    this.title,
    this.trailing,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (BuildContext context) {
        return CupertinoTableViewController(
          action: trailing,
          title: title,
          // item: item,
          previousTitle: previousTitle,
          onItemTap: onItemTap,
          items: items,
          onEditing: (bool editing) {
            if (editing != null) {
              if (editing) {
                if (onEditingStarted != null) onEditingStarted();
              } else {
                if (onEditingComplete != null) onEditingComplete();
              }
            }
          },
        );
      },
      android: (BuildContext context) {
        return Container();
      },
    );
  }
}

class CupertinoTableViewController extends StatefulWidget {
  final String title, previousTitle;
  final Widget action;
  final Function(NativeListTile item, bool selected) onSelected;
  final ValueChanged<bool> onEditing;
  final ValueChanged<dynamic> onItemTap;
  final List<NativeListTile> items;

  CupertinoTableViewController({
    @required this.title,
    this.previousTitle = "Back",
    this.action,
    this.onEditing,
    this.onItemTap,
    this.items,
    this.onSelected,
  });

  @override
  _CupertinoTableViewControllerState createState() =>
      _CupertinoTableViewControllerState();
}

class _CupertinoTableViewControllerState
    extends State<CupertinoTableViewController> {
  List<List<String>> randomizedContacts;
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  List<CupertinoTableCell<NativeListTile>> _items = [];

  @override
  void initState() {
    _items = widget.items
        .map((NativeListTile item) => new CupertinoTableCell<NativeListTile>(
            selected: false, data: item, editable: true))
        .toList();
    setState(() {});
    super.initState();
    repopulateList();
  }

  void repopulateList() {
    // final Random random = Random();
    // randomizedContacts = List<List<String>>.generate(100, (int index) {
    //   return contacts[random.nextInt(contacts.length)]
    //     // Randomly adds a telephone icon next to the contact or not.
    //     ..add(random.nextBool().toString());
    // });
  }

  bool _isEditing = false;

  void _deselectAll() {
    for (var item in _items) {
      setState(() {
        item.selected = false;
      });
    }
  }

  void _selectAll() {
    for (var item in _items) {
      setState(() {
        item.selected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _editingButton = Container(
      padding: EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        onTap: () {
          if (!_isDisposed)
            setState(() {
              _isEditing = !_isEditing;
            });
          if (widget?.onEditing != null) widget.onEditing(_isEditing);
          if (!_isEditing) _deselectAll();
        },
        child: _isEditing
            ? const Text("Cancel",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.activeBlue,
                ))
            : const Text("Edit",
                style: TextStyle(
                  color: CupertinoColors.activeBlue,
                )),
      ),
    );
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.title,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text(widget?.title ?? "Title"),
              // We're specifying a back label here because the previous page
              // is a Material page. CupertinoPageRoutes could auto-populate
              // these back labels.
              previousPageTitle: widget?.previousTitle ?? "",
              leading: widget?.previousTitle != null
                  ? _isEditing ? null : widget?.action
                  : _editingButton,
              trailing: widget?.previousTitle != null
                  ? _editingButton
                  : _isEditing ? null : widget?.action,
            ),
            CupertinoSliverRefreshControl(
              onRefresh: () {
                return Future<void>.delayed(const Duration(seconds: 2))
                  ..then<void>((_) {
                    if (mounted) {
                      setState(() => repopulateList());
                    }
                  });
              },
            ),
            SliverSafeArea(
              top: false, // Top safe area is consumed by the navigation bar.
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    // return _ListItem(
                    //   editing: _isEditing,
                    //   name: randomizedContacts[index][0],
                    //   place: randomizedContacts[index][1],
                    //   date: randomizedContacts[index][2],
                    //   called: randomizedContacts[index][3] == 'true',
                    // );
                    // final _item = _items[index];
                    CupertinoTableCell _cell = _items[index];
                    final NativeListTile _item = _cell?.data;

                    return NativeListTile(
                      editing: _isEditing,
                      selected: _cell.selected,
                      lastItem: index == _items.length,
                      // avatar: Container(
                      //   height: 60.0,
                      //   width: 60.0,
                      //   decoration: BoxDecoration(
                      //     color: Colors.lightBlue,
                      //     borderRadius: BorderRadius.circular(8.0),
                      //   ),
                      // ),

                      leading: NativeIcon(
                        Icons.phone,
                        iosIcon: CupertinoIcons.phone_solid,
                      ),

                      title: _item?.title,
                      subtitle: _item?.subtitle,
                      trailing: _item?.trailing,
                      ios: CupertinoListTileData(
                        hideLeadingIcon: _item?.ios?.hideLeadingIcon,
                        style: _item?.ios?.style,
                        accessory: _item?.ios?.accessory,
                        editingAction: _item?.ios?.editingAction,
                        editingAccessory: _item?.ios?.editingAccessory,
                        accessoryTap: _item?.ios?.accessoryTap,
                        onTapDown: (TapDownDetails details) {
                          print("On Tap Down..");
                          setState(() {
                            _cell.selected = !_cell.selected;
                          });
                        },
                        onTapCancel: () {
                          print("On Tap Cancel..");
                          setState(() {
                            _cell.selected = false;
                          });
                        },
                      ),
                      onTap: () {
                        print("Item Tapped...");
                        if (!_isEditing) {
                          setState(() {
                            _cell.selected = false;
                          });
                          if (widget?.onItemTap != null)
                            widget.onItemTap(_cell?.data);
                        } else {
                          if (widget?.onSelected != null)
                            widget.onSelected(_cell?.data, _cell.selected);
                        }
                      },
                    );
                  },
                  childCount: _items.length,
                ),
              ),
            ),
          ],
        ),
        persistentFooterButtons: !_isEditing
            ? null
            : <Widget>[
                NativeToolBar(
                  height: 35.0,
                  leading: NativeTextButton(
                    label: "Select All",
                    onPressed: () => _selectAll(),
                  ),
                  trailing: NativeTextButton(
                    label: "Delete",
                  ),
                ),
              ],
      ),
    );
  }
}

class CupertinoTableCell<T> {
  bool selected;
  final bool editable;
  dynamic data;

  CupertinoTableCell({
    this.selected = false,
    this.editable = true,
    this.data,
  });
}

// List<List<String>> contacts = <List<String>>[
//   <String>['George Washington', 'Westmoreland County', ' 4/30/1789'],
//   <String>['John Adams', 'Braintree', ' 3/4/1797'],
//   <String>['Thomas Jefferson', 'Shadwell', ' 3/4/1801'],
//   <String>['James Madison', 'Port Conway', ' 3/4/1809'],
//   <String>['James Monroe', 'Monroe Hall', ' 3/4/1817'],
//   <String>['Andrew Jackson', 'Waxhaws Region South/North', ' 3/4/1829'],
//   <String>['John Quincy Adams', 'Braintree', ' 3/4/1825'],
//   <String>['William Henry Harrison', 'Charles City County', ' 3/4/1841'],
//   <String>['Martin Van Buren', 'Kinderhook New', ' 3/4/1837'],
//   <String>['Zachary Taylor', 'Barboursville', ' 3/4/1849'],
//   <String>['John Tyler', 'Charles City County', ' 4/4/1841'],
//   <String>['James Buchanan', 'Cove Gap', ' 3/4/1857'],
//   <String>['James K. Polk', 'Pineville North', ' 3/4/1845'],
//   <String>['Millard Fillmore', 'Summerhill New', '7/9/1850'],
//   <String>['Franklin Pierce', 'Hillsborough New', ' 3/4/1853'],
//   <String>['Andrew Johnson', 'Raleigh North', ' 4/15/1865'],
//   <String>['Abraham Lincoln', 'Sinking Spring', ' 3/4/1861'],
//   <String>['Ulysses S. Grant', 'Point Pleasant', ' 3/4/1869'],
//   <String>['Rutherford B. Hayes', 'Delaware', ' 3/4/1877'],
//   <String>['Chester A. Arthur', 'Fairfield', ' 9/19/1881'],
//   <String>['James A. Garfield', 'Moreland Hills', ' 3/4/1881'],
//   <String>['Benjamin Harrison', 'North Bend', ' 3/4/1889'],
//   <String>['Grover Cleveland', 'Caldwell New', ' 3/4/1885'],
//   <String>['William McKinley', 'Niles', ' 3/4/1897'],
//   <String>['Woodrow Wilson', 'Staunton', ' 3/4/1913'],
//   <String>['William H. Taft', 'Cincinnati', ' 3/4/1909'],
//   <String>['Theodore Roosevelt', 'New York City New', ' 9/14/1901'],
//   <String>['Warren G. Harding', 'Blooming Grove', ' 3/4/1921'],
//   <String>['Calvin Coolidge', 'Plymouth', '8/2/1923'],
//   <String>['Herbert Hoover', 'West Branch', ' 3/4/1929'],
//   <String>['Franklin D. Roosevelt', 'Hyde Park New', ' 3/4/1933'],
//   <String>['Harry S. Truman', 'Lamar', ' 4/12/1945'],
//   <String>['Dwight D. Eisenhower', 'Denison', ' 1/20/1953'],
//   <String>['Lyndon B. Johnson', 'Stonewall', '11/22/1963'],
//   <String>['Ronald Reagan', 'Tampico', ' 1/20/1981'],
//   <String>['Richard Nixon', 'Yorba Linda', ' 1/20/1969'],
//   <String>['Gerald Ford', 'Omaha', 'August 9/1974'],
//   <String>['John F. Kennedy', 'Brookline', ' 1/20/1961'],
//   <String>['George H. W. Bush', 'Milton', ' 1/20/1989'],
//   <String>['Jimmy Carter', 'Plains', ' 1/20/1977'],
//   <String>['George W. Bush', 'New Haven', ' 1/20, 2001'],
//   <String>['Bill Clinton', 'Hope', ' 1/20/1993'],
//   <String>['Barack Obama', 'Honolulu', ' 1/20/2009'],
//   <String>['Donald J. Trump', 'New York City', ' 1/20/2017'],
// ];
