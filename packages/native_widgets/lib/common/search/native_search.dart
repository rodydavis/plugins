part of native_widgets;

class NativeSearchWidget extends StatelessWidget {
  final bool isSearching;
  final String search;
  final ValueChanged<String> onChanged;
  final VoidCallback onCancel, onSearch;

  NativeSearchWidget({
    this.isSearching = false,
    this.onChanged,
    this.search,
    this.onCancel,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      android: (BuildContext context) => MaterialSearchBar(
            search: search,
            onSearchChanged: onChanged,
          ),
      ios: (BuildContext context) => CupertinoSearchBar(
            initialValue: search,
            onChanged: onChanged,
            alwaysShowAppBar: true,
            onCancel: onCancel,
            onSearch: onSearch,
            isSearching: isSearching,
          ),
    );
  }
}
