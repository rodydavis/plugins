part of native_widgets;

class NativeTextInput extends StatelessWidget {
  final Widget leading, trailing;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction kayboardAction;
  final bool autoFocus, autoCorrect, obscureText, enabled, maxLengthEnforced;
  final FocusNode focusNode;
  final TextAlign textAlign;
  final int maxLength, maxLines;
  final ValueChanged<String> onChanged, onSubmitted;
  final VoidCallback onEditingComplete;

  NativeTextInput({
    this.leading,
    this.trailing,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.kayboardAction = TextInputAction.done,
    this.autoCorrect = true,
    this.autoFocus = false,
    this.obscureText = false,
    this.enabled = true,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.maxLines = 1,
    this.maxLengthEnforced = true,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (BuildContext context) {
        return CupertinoTextField(
          controller: controller,
          prefix: leading,
          suffix: trailing,
          clearButtonMode: OverlayVisibilityMode.editing,
          textInputAction: kayboardAction,
          keyboardType: keyboardType,
          autocorrect: autoCorrect,
          autofocus: autoFocus,
          obscureText: obscureText,
          enabled: enabled,
          focusNode: focusNode,
          textAlign: textAlign,
          maxLength: maxLength,
          maxLines: maxLines,
          maxLengthEnforced: maxLengthEnforced,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          onEditingComplete: onEditingComplete,
        );
      },
      android: (BuildContext context) {
        return ListTile(
          leading: leading,
          trailing: trailing,
          title: TextField(
            controller: controller,
            textInputAction: kayboardAction,
            keyboardType: keyboardType,
            autocorrect: autoCorrect,
            autofocus: autoFocus,
            obscureText: obscureText,
            enabled: enabled,
            focusNode: focusNode,
            textAlign: textAlign,
            maxLength: maxLength,
            maxLines: maxLines,
            maxLengthEnforced: maxLengthEnforced,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            onEditingComplete: onEditingComplete,
          ),
        );
      },
    );
  }
}
