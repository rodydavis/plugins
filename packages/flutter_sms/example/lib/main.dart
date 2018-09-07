import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:share/share.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('SMS/MMS Example'),
        ),
        body: SocialPage(),
      ),
    );
  }
}

class SocialPage extends StatefulWidget {
  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PageController controller = new PageController();
  TextEditingController _controllerName, _controllerDesc;
  String _formSubject;
  String _formMessage;
  bool _group = false;
  bool isEdit = false;
  String _message;
  List<String> _phones = <String>[];

  @override
  void initState() {
    super.initState();
    _controllerName = TextEditingController(text: _formSubject);
    _controllerDesc = TextEditingController(text: _formMessage);
  }

  void _sendSMS(String message, List<String> recipents) async {
    if (!_group) {
      final String _first = recipents.isEmpty ? "" : recipents[0];
      recipents.clear();
      if (_first.isNotEmpty) recipents.add(_first);
    }
    final String _result =
        await FlutterSms.sendSMS(message: message, recipients: recipents)
            .catchError((dynamic onError) {
      print(onError);
    });
    if (mounted) setState(() => _message = _result);
  }

  Widget _getAction(BuildContext context, VoidCallback onTap, IconData icon,
      String label, Color color) {
    return Container(
      margin: const EdgeInsets.only(left: 4.0),
      padding: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: color,
              onPressed: () {},
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        onPressed: onTap,
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 20.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              icon,
                              color: Colors.white,
                            ),
                            Text(
                              label,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _shareMessage(BuildContext context) {
    _message = _getMessage();
    if (_message == null || _message.isEmpty) {
      final SnackBar snackbar = SnackBar(
          duration: Duration(seconds: 3),
          content: const Text("Message Required"));
      _scaffoldKey.currentState.showSnackBar(snackbar);
    } else {
      final RenderBox box = context.findRenderObject();
      Share.share(_message,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }

  Widget _phoneTile(String name) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.black12,
        onPressed: () {
          isEdit = true;
          _tempItem = name;
          showDemoDialog<String>(
            context: context,
            child: SingleItem(
              title: "Edit Phone Number",
              item: name,
              label: "Phone Number",
              error: "Number cannot be blank!",
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                // color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => setState(() => _phones.remove(name)),
            ),
          ],
        ),
      ),
    );
  }

  String _getMessage() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return "$_formSubject\n\n$_formMessage\n\n";
    }
    return "";
  }

  String _tempItem = "";
  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((dynamic value) {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        final String _item = value;
        if (isEdit) {
          _phones.remove(_tempItem);
          setState(() => _addPhone(_item));
        } else {
          setState(() => _addPhone(_item));
        }
        isEdit = false;
      }
    });
  }

  void _addPhone(String item) {
    print("$item => $_phones");
    if (_phones.toString().toLowerCase().contains(item.toLowerCase())) {
      final SnackBar snackbar = SnackBar(
          duration: Duration(seconds: 2),
          content: const Text("Number Already Added"));
      _scaffoldKey.currentState?.showSnackBar(snackbar);
    } else {
      _phones.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Form _form = Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: TextFormField(
              // maxLines: null,
              controller: _controllerName,
              decoration: const InputDecoration(labelText: 'Title'),
              // validator: (val) => val.length < 1 ? 'Subject Required' : null,
              onSaved: (String val) => _formSubject = val,
              // keyboardType: TextInputType.multiline,
              obscureText: false,
            ),
          ),
          ListTile(
            title: TextFormField(
              maxLines: null,
              controller: _controllerDesc,
              decoration: const InputDecoration(labelText: 'Description'),
              keyboardType: TextInputType.multiline,
              // validator: (val) => val.length < 1 ? 'Message Required' : null,
              onSaved: (String val) => _formMessage = val,
              obscureText: false,
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _form,
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: _group
                      ? const Text("Phone Numbers")
                      : const Text("Phone Number"),
                  subtitle: _group || _phones.isEmpty
                      ? const Text('Tap to Add')
                      : Text(
                          _phones.isEmpty
                              ? "Tap to Add"
                              : _phones[0].toString(),
                        ),
                  trailing: const Icon(Icons.add),
                  onTap: () {
                    _group
                        ? showDemoDialog<String>(
                            context: context,
                            child: SingleItem(
                              title: "Add Phone Number",
                              label: "Phone Number",
                              error: "Number cannot be blank!",
                            ))
                        : showDemoDialog<String>(
                            context: context,
                            child: SingleItem(
                              title: _phones.isEmpty
                                  ? "New Phone Number"
                                  : "Edit Phone Number",
                              item: _phones.isEmpty ? null : _phones[0],
                              label: "Phone Number",
                              error: "Number cannot be blank!",
                            ),
                          );
                  },
                ),
                _phones == null || _phones.isEmpty || !_group
                    ? Container(height: 0.0)
                    : Container(
                        height: 60.0,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: List<Widget>.generate(_phones.length,
                                (int index) {
                              return _phoneTile(_phones[index]);
                            }),
                          ),
                        ),
                      ),
                ListTile(
                  leading: const Icon(Icons.group_add),
                  title: const Text('Group Message'),
                  trailing: NativeSwitch(
                    value: _group,
                    onChanged: (bool value) => setState(() => _group = value),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: _getAction(context, () => _shareMessage(context),
                          Icons.share, "Share", Colors.blue),
                    ),
                    // Container(
                    //   width: 200.0,
                    Expanded(
                      child: _getAction(
                          context,
                          () => _sendSMS(_getMessage(), _phones),
                          Icons.message,
                          "Message",
                          Colors.green),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SingleItem extends StatefulWidget {
  final String item, title, label, error;
  SingleItem({
    this.item,
    @required this.title,
    @required this.label,
    @required this.error,
  });
  @override
  SingleItemState createState() => SingleItemState(item: item);
}

class SingleItemState extends State<SingleItem> {
  SingleItemState({this.item});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String item;

  @override
  Widget build(BuildContext context) {
    String _title = widget.item == null ? 'New' : 'Edit';
    _title += " ${widget.label ?? ""}";
    _title = widget.title ?? _title.trim();
    return (AlertDialog(
      title: Text(
        _title,
      ),
      content: Form(
        key: formKey,
        child: TextFormField(
          autofocus: true,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(labelText: widget.label ?? ""),
          validator: (String val) =>
              val.isEmpty ? widget.label ?? 'Cannot be Blank' : null,
          onSaved: (String val) => item = val,
          initialValue: item,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child:
              const Text('Save', style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () {
            final FormState form = formKey.currentState;
            if (form.validate()) {
              form.save();
              Navigator.pop(context, item);
            }
          },
        ),
      ],
    ));
  }
}
