import 'package:flutter/material.dart';

class MaterialSearchBar extends StatelessWidget {
  final String search, name;

  final bool isSearching;

  final Function(String) onSearchChanged;

  const MaterialSearchBar({
    this.search,
    this.name,
    this.onSearchChanged,
    this.isSearching = false,
  });

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
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.search),
              ),
              border: InputBorder.none,
              hintText: 'Search'),
          autofocus: true,
          autocorrect: false,
          onChanged: (String value) => onSearchChanged(value),
        ),
      );
    }

    return Text(title);
  }
}
