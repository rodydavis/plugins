part of native_widgets;

class NativeSearchWidget extends AnimatedWidget {
  final String search;
  final bool isSearching;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged, onSubmitted;
  final VoidCallback onCancel, onClear;
  final bool autoFocus, enabled;
  final Animation<double> animation;

  const NativeSearchWidget({
    Key key,
    this.onChanged,
    this.search,
    this.onCancel,
    this.isSearching = false,
    this.onClear,
    this.animation,
    this.onSubmitted,
    this.autoFocus = false,
    this.focusNode,
    this.controller,
    this.enabled = true,
  })  : assert(controller != null),
        assert(focusNode != null),
        super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      android: (BuildContext context) => MaterialSearchBar(
            search: search,
            isSearching: isSearching,
            onSearchChanged: onChanged,
          ),
      ios: (BuildContext context) => CupertinoSearchBar(
            enabled: enabled,
            onChanged: onChanged,
            onCancel: onCancel,
            onClear: onClear,
            onSubmitted: onSubmitted,
            animation: animation,
            controller: controller,
            autoFocus: autoFocus,
            focusNode: focusNode,
          ),
    );
  }
}
