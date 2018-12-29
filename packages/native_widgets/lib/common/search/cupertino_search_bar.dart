import 'package:flutter/material.dart';
import '../../utils/ios_search_bar.dart';

class CupertinoSearchBar extends StatefulWidget {
  final TextStyle searchText;
  final Color searchBackground, searchIconColor, searchCursorColor;
  final ValueChanged<String> onChanged;
  // final ValueChanged<bool> onSearching;
  final VoidCallback onCancel, onSearch;
  final String initialValue;
  final bool alwaysShowAppBar, isSearching;

  const CupertinoSearchBar({
    this.searchBackground,
    this.searchCursorColor,
    this.searchIconColor,
    this.searchText,
    this.onChanged,
    this.initialValue,
    this.alwaysShowAppBar = false,
    this.onCancel,
    this.onSearch,
    this.isSearching = false,
  });

  @override
  CupertinoSearchBarState createState() {
    return new CupertinoSearchBarState();
  }
}

class CupertinoSearchBarState extends State<CupertinoSearchBar>
    with SingleTickerProviderStateMixin {
  TextStyle searchText;
  Color searchBackground, searchIconColor, searchCursorColor;

  TextEditingController _searchTextController;
  FocusNode _searchFocusNode = new FocusNode();
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _searchTextController = TextEditingController(text: widget.initialValue);

    _animationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _searchFocusNode.addListener(() {
      if (!_animationController.isAnimating) {
        _animationController.forward();
        if (widget?.onSearch != null) widget.onSearch();
      }
    });
    if (!widget.alwaysShowAppBar || widget.isSearching) {
      _startSearch();
    }
    super.initState();
  }

  void _startSearch() {
    _searchTextController.clear();
    _animationController.forward();
  }

  void _cancelSearch() {
    if (widget.alwaysShowAppBar) {
      _searchTextController.clear();
      _searchFocusNode.unfocus();
      _animationController.reverse();
    }
    if (widget?.onCancel != null) widget.onCancel();
  }

  void _clearSearch() {
    _searchTextController.clear();
    widget?.onChanged("");
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchFocusNode.dispose();
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.alwaysShowAppBar)
      FocusScope.of(context).requestFocus(_searchFocusNode);

    return new IOSSearchBar(
      controller: _searchTextController,
      focusNode: _searchFocusNode,
      animation: _animation,
      onCancel: _cancelSearch,
      onClear: _clearSearch,
      onUpdate: widget?.onChanged,
      autoFocus: widget.isSearching,
    );
  }
}
