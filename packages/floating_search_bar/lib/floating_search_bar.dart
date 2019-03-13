import 'package:flutter/material.dart';

import 'ui/sliver_search_bar.dart';
export 'ui/sliver_search_bar.dart';

class FloatingSearchBar extends StatefulWidget {
  FloatingSearchBar({
    this.body,
    this.drawer,
    this.trailing,
    this.leading,
    this.controller,
    List<Widget> children,
  }) : _childDelagate = SliverChildListDelegate(
          children,
        );

  FloatingSearchBar.builder({
    this.body,
    this.drawer,
    this.trailing,
    this.leading,
    this.controller,
    IndexedWidgetBuilder itemBuilder,
    int itemCount,
  }) : _childDelagate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
        );

  final Widget leading, trailing, body, drawer;
  final SliverChildDelegate _childDelagate;
  final TextEditingController controller;

  @override
  _FloatingSearchBarState createState() => _FloatingSearchBarState();
}

class _FloatingSearchBarState extends State<FloatingSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.drawer,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFloatingBar(
            leading: widget.leading,
            floating: true,
            title: TextField(
              controller: widget.controller,
              decoration: InputDecoration.collapsed(
                hintText: "Search...",
              ),
              autofocus: false,
            ),
            trailing: CircleAvatar(
              child: Text("A"),
            ),
          ),
          SliverList(
            delegate: widget._childDelagate,
          ),
        ],
      ),
    );
  }
}
