part of native_widgets;

class NativeIconButton extends StatelessWidget {
  final Icon icon, iosIcon;
  final Key widgetKey;
  final VoidCallback onPressed;

  NativeIconButton({
    Key key,
    @required this.icon,
    this.iosIcon,
    this.onPressed,
    this.widgetKey,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformIconButton(
      key: key,
      widgetKey: widgetKey,
      icon: icon,
      iosIcon: iosIcon,
      androidIcon: icon,
      onPressed: onPressed,
    );
  }
}
