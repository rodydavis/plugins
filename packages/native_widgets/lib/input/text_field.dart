part of native_widgets;

class NativeTextInput extends StatelessWidget {
  final Widget leading, trailing;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction kayboardAction;
  final bool autoFocus, autoCorrect;

  NativeTextInput({
    this.leading,
    this.trailing,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.kayboardAction = TextInputAction.done,
    this.autoCorrect = true,
    this.autoFocus = false,
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
        );
      },
      android: (BuildContext context) {
        return ListTile(
          leading: leading,
          trailing: trailing,
          title: TextFormField(
            controller: controller,
            textInputAction: kayboardAction,
            keyboardType: keyboardType,
            autocorrect: autoCorrect,
            autofocus: autoFocus,
          ),
        );
      },
    );
  }
}
