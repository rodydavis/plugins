part of native_widgets;

class NativeIconButton extends StatelessWidget {
  final Icon icon, iosIcon;
  final Key widgetKey;
  final VoidCallback onPressed;
  final EdgeInsets padding;

  NativeIconButton({
    Key key,
    @required this.icon,
    this.iosIcon,
    this.onPressed,
    this.widgetKey,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformIconButton(
      padding: padding,
      key: key,
      widgetKey: widgetKey,
      icon: icon,
      iosIcon: iosIcon,
      androidIcon: icon,
      onPressed: onPressed,
    );
  }
}
