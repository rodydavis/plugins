part of native_widgets;

class NativeIconButton extends StatelessWidget {
  final Icon icon, iosIcon;
  final VoidCallback onPressed;

  NativeIconButton({
   @required this.icon,
    this.iosIcon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformIconButton(
      icon: icon,
      iosIcon: iosIcon,
      androidIcon: icon,
      onPressed: onPressed,
    );
  }
}
