import 'package:flutter/material.dart';

class MaterialSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String search, name;

  final bool isSearching, autoFocus, autoCorrect;

  final Function(String) onSearchChanged;

  const MaterialSearchBar({
    Key key,
    this.controller,
    this.focusNode,
    this.search,
    this.name,
    this.onSearchChanged,
    this.isSearching = false,
    this.autoFocus = false,
    this.autoCorrect = true,
  })  : assert(controller != null),
        assert(focusNode != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = name ?? "search".toString();
    var _theme = Theme.of(context);

    if (isSearching) {
      return Container(
        padding: const EdgeInsets.only(left: 8.0),
        height: 38.0,
        margin: EdgeInsets.only(bottom: 2.0),
        decoration: BoxDecoration(
          color: _theme?.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.search),
              ),
              border: InputBorder.none,
              hintText: 'Search'),
          autofocus: autoFocus,
          autocorrect: autoCorrect,
          onChanged: (String value) => onSearchChanged(value),
        ),
      );
    }

    return Text(title);
  }
}
