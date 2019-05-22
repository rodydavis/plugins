import 'package:flutter/material.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';

class LayoutExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: Text('Responsive Layout Example'),
      drawer: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings Page'),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Info Page'),
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('Library Page'),
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help Page'),
          ),
        ],
      ),
      endIcon: Icons.filter_list,
      endDrawer: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.filter_list),
            title: Text('Filter List'),
            subtitle: Text('Hide and show items'),
            trailing: Switch(
              value: true,
              onChanged: (val) {},
            ),
          ),
          ListTile(
            leading: Icon(Icons.image_aspect_ratio),
            title: Text('Size Settings'),
            subtitle: Text('Change size of images'),
          ),
          ListTile(
            title: Slider(
              value: 0.5,
              onChanged: (val) {},
            ),
          ),
          ListTile(
            leading: Icon(Icons.sort_by_alpha),
            title: Text('Sort List'),
            subtitle: Text('Change layout behavior'),
            trailing: Switch(
              value: false,
              onChanged: (val) {},
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.search),
        onPressed: () {},
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {},
      ),
    );
  }
}
