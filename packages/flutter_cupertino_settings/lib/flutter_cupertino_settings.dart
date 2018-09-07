library flutter_cupertino_settings;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const CS_ITEM_HEIGHT = 50.0;
const CS_HEADER_COLOR = const Color(0xFFEEEEF3);
const CS_BORDER_COLOR = Colors.black12;
const CS_TEXT_COLOR = Colors.black;
const CS_HEADER_TEXT_COLOR = Colors.black54;
const CS_ITEM_PADDING = const EdgeInsets.only(left: 10.0, right: 10.0);
const CS_HEADER_FONT_SIZE = 14.0;
const CS_ITEM_NAME_SIZE = 16.0;
const CS_BUTTON_FONT_SIZE = CS_ITEM_NAME_SIZE;
const CS_ICON_PADDING = const EdgeInsets.only(right: 10.0);
const CS_DEFAULT_STYLE = const CSWidgetStyle();
const CS_CHECK_COLOR = Colors.blue;
const CS_CHECK_SIZE = 16.0;

/// Event for [CSSelection]
typedef void SelectionCallback(int selected);

class CupertinoSettings extends StatelessWidget {
  final List<Widget> items;
  CupertinoSettings(this.items);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return items[index];
      },
    );
  }
}

/// This widgets is used as a grouping separator.
/// The [title] attribute is optional.
class CSHeader extends StatelessWidget {
  final String title;
  CSHeader([this.title = '']);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.only(left: 10.0, top: 30.0, bottom: 5.0),
      child: new Text(title.toUpperCase(), style: new TextStyle(color: CS_HEADER_TEXT_COLOR, fontSize: CS_HEADER_FONT_SIZE)),
      decoration: new BoxDecoration(
          color: CS_HEADER_COLOR,
          border: new Border(
              bottom: new BorderSide(color: CS_BORDER_COLOR, width: 1.0)
          )
      ),
    );
  }
}

/// Used to display a widget of any kind in [CupertinoSettings]
/// It provices the correct height, color and border to create the intended look
/// The optional [alignment] attribute allows to specify the aligment inside the container
/// The optional [style] attribute allows to specify a style (e.g. an Icon)
class CSWidget extends StatelessWidget {
  final Widget widget;
  final AlignmentGeometry alignment;
  final double height;
  final CSWidgetStyle style;

  CSWidget(this.widget, {this.alignment, this.height = CS_ITEM_HEIGHT, this.style = CS_DEFAULT_STYLE});

  @override
  Widget build(BuildContext context) {

    Widget child;

    //style.icon
    if (style.icon != null) {
      child = new Row(children: <Widget>[
        new Container(
          child: style.icon,
          padding: CS_ICON_PADDING,
        ),
        new Expanded(child: widget)
      ]);
    } else {
      child = widget;
    }

    return new Container(
        alignment: alignment,
        height: height,
        padding: CS_ITEM_PADDING,
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
              bottom: new BorderSide(color: CS_BORDER_COLOR, width: 1.0)
          ),
        ),
        child: child
    );
  }

}

/// A title [name] in combination with any widget [contentWidget]
/// extends [CSWidget]
/// Provides the correct paddings and text properties
class CSControl extends CSWidget {
  final String name;
  final Widget contentWidget;

  CSControl(this.name, this.contentWidget, {CSWidgetStyle style = CS_DEFAULT_STYLE}) : super(
      new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new Text(name, style: new TextStyle(fontSize: CS_ITEM_NAME_SIZE, color: CS_TEXT_COLOR)),
          contentWidget
        ],
      ),
      style: style
  );
}

/// A button-cell inside [CupertinoSettings]
/// 3 different types are available (they only affect the design):
/// [CSButtonType.DESTRUCTIVE] Red and centered
/// [CSButtonType.DEFAULT] Blue and left aligned
/// [CSButtonType.DEFAULT_CENTER] Blue and centered
/// Provides the correct paddings and text properties
///
/// It is quite complex:
///
/// -- Widget
///   |- Flex
///     |- Expand
///       |- CupertinoButton
///         |- Container        (<--- For text-alignment)
///           |- Text
///
/// This "hack" is mandatory to archive that...
/// 1) The button can be aligned
/// 2) The entire row is touch-sensitive
class CSButton extends CSWidget {
  final CSButtonType type;
  final String text;
  final VoidCallback pressed;
  CSButton(this.type, this.text, this.pressed, {CSWidgetStyle style = CS_DEFAULT_STYLE}) : super(
      new Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          new Expanded(
            child: new CupertinoButton(
              padding: EdgeInsets.zero,
              child: new Container(
                alignment: type.alignment,
                child: new Text(text, style: new TextStyle(color: type.color, fontSize: CS_BUTTON_FONT_SIZE)),
              ),
              onPressed: pressed,
            ),
          ),
        ],
      ),
      style: style
  );
}

/// Provides a button for navigation
class CSLink extends CSWidget {
  final String text;
  final VoidCallback pressed;
  CSLink(this.text, this.pressed, {CSWidgetStyle style = CS_DEFAULT_STYLE}) : super (
      new CupertinoButton(
          padding: EdgeInsets.zero,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Text(text, style: new TextStyle(fontSize: CS_ITEM_NAME_SIZE, color: CS_TEXT_COLOR)),
              new Icon(Icons.keyboard_arrow_right, color: Colors.black26)
            ],
          ),
          onPressed: pressed
      ),
      style: style
  );

}

/// A selection view
/// Allows to select between multiple items
/// Every item is represented by a String
///
/// If an item is selected, onSelected is called with its index
///
/// eg:
/// items = ["hello","world","flutter"]
/// select "world"
///
/// onSelected(1)
class CSSelection extends StatefulWidget {

  final List<String> items;
  final SelectionCallback onSelected;
  final int currentSelection;

  CSSelection(this.items, this.onSelected, {this.currentSelection = 0});

  @override
  State<StatefulWidget> createState() {
    return new CSSelectionState(items, currentSelection, onSelected);
  }

}

/// [State] for [CSSelection]
class CSSelectionState extends State<CSSelection> {

  int currentSelection;
  final SelectionCallback onSelected;
  final List<String> items;

  CSSelectionState(this.items, this.currentSelection, this.onSelected);

  @override
  Widget build(BuildContext context) {

    List<Widget> widgets = new List<Widget>();
    for(int i = 0; i < items.length; i++) {
      widgets.add(createItem(items[i],i));
    }

    return new Column(
        children: widgets
    );
  }

  Widget createItem(String name, int index) {
    return new CSWidget(
        new CupertinoButton(
            onPressed: (){
              if (index != this.currentSelection) {
                setState(() {
                  this.currentSelection = index;
                });
                onSelected(index);
              }
            },
            pressedOpacity: 1.0,
            child: new Row(
              children: <Widget>[
                new Expanded(
                    child: new Text(
                        name,
                        style: new TextStyle(fontSize: CS_ITEM_NAME_SIZE, color: CS_TEXT_COLOR))
                ),
                new Icon(Icons.check,
                    color: (index == currentSelection ? CS_CHECK_COLOR : Colors.transparent),
                    size: CS_CHECK_SIZE
                )
              ],
            )
        )
    );
  }

}

/// Defines style attributes that can be applied to every [CSWidget]
class CSWidgetStyle {
  final Icon icon;
  const CSWidgetStyle({this.icon});
}

/// Defines different types for [CSButton]
/// Specifies color and alignment
class CSButtonType {
  static const DESTRUCTIVE = const CSButtonType(Colors.red, AlignmentDirectional.center);
  static const DEFAULT = const CSButtonType(Colors.blue, AlignmentDirectional.centerStart);
  static const DEFAULT_CENTER = const CSButtonType(Colors.blue, AlignmentDirectional.center);

  final Color color;
  final AlignmentGeometry alignment;

  const CSButtonType(this.color, this.alignment);
}
