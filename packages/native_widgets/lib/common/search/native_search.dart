part of native_widgets;

class NativeSearchWidget extends StatelessWidget {
  final String search;
  final ValueChanged<String> onChanged;
  final ValueChanged<bool> onSearching;

  NativeSearchWidget({
    this.onChanged,
    this.search,
    this.onSearching,
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
            onSearching: onSearching,
          ),
    );
  }
}
