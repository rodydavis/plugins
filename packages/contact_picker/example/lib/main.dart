import 'package:flutter/material.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:simple_permissions/simple_permissions.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ContactPicker _contactPicker = new ContactPicker();
  Contact _contact;

  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();

    initPermissions();
  }

  void initPermissions() async {
    final bool granted =
        await SimplePermissions.checkPermission(Permission.ReadContacts);
    setState(() {
      _hasPermissions = granted;
    });
  }

  void _requestPermissions() async {
    final  granted =
        await SimplePermissions.requestPermission(Permission.ReadContacts);
    setState(() {
      _hasPermissions = granted == PermissionStatus.authorized;
    });
  }

  void _updateContactInfo(Contact c) {
    if (c != null) {
      //Name
      String _firstName;
      String _middleName;
      String _lastName;
      try {
        _firstName = c.givenName.toString();
        _middleName = c.middleName.toString();
        _lastName = c.familyName.toString();
      } catch (e) {
        _firstName = "";
        _middleName = "";
        _lastName = "";
      }
      print(
          "Name => ${c.fullName}\nFirst: $_firstName\nMiddle: $_middleName\nLast: $_lastName");

      //Phone Numbers
      String _home = "";
      String _cell = "";
      String _office = "";
      for (PhoneNumber item in c.phones) {
        if (item.label.contains('home')) {
          _home = item.number.toString();
        } else if (item.label.contains('mobile')) {
          _cell = item.number.toString();
        } else if (item.label.contains('work')) {
          _office = item.number.toString();
        } else {
          _cell = item.number.toString();
        }
      }
      print("Phones\nHome: $_home\nOffice: $_office\nCell: $_cell");

      //Email
      String _email;
      try {
        if (c.emails != null && c.emails.isNotEmpty) {
          _email = c.emails.first.email.toString();
          print("Email: $_email\n ");
        }
      } catch (e) {
        _email = "";
      }

      //Address Info
      String _street = "";
      String _city = "";
      String _state = "";
      String _zip = "";

      if (c.postalAddresses != null && c.postalAddresses.isNotEmpty) {
        _street = c.postalAddresses.first.street.toString();
        _city = c.postalAddresses.first.city.toString();
        _state = c.postalAddresses.first.region.toString();
        _zip = c.postalAddresses.first.postcode.toString();
        print("Address: $_street $_city, $_state $_zip\n");
      }
    } else {
      print("No Contact Selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              !_hasPermissions
                  ? new RaisedButton(
                      child: const Text("Request permissions"),
                      onPressed: _requestPermissions,
                      color: Colors.amber,
                    )
                  : new Container(),
              new Container(
                height: 20.0,
              ),
              new RaisedButton(
                child: const Text(
                  "Select Contact",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  final Contact contact = await _contactPicker.selectContact();
                  setState(() {
                    _contact = contact;
                    _updateContactInfo(_contact);
                  });
                },
                color: Colors.blue,
              ),
              new Container(
                height: 20.0,
              ),
              new Text(
                _contact == null ? 'No contact selected.' : _contact.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
