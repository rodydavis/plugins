part of native_widgets;

enum NativeTextTheme { title, subtitle, detail, custom }

class NativeText extends StatelessWidget {
  final String data;
  final TextStyle style;
  final int maxLines;
  final NativeTextTheme type;

  const NativeText(
    this.data, {
    Key key,
    this.style,
    this.maxLines = 1,
    this.type = NativeTextTheme.detail,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      key: key,
      android: (BuildContext context) {
        switch (type) {
          case NativeTextTheme.title:
            return Text(
              data,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.title,
            );
          case NativeTextTheme.subtitle:
            return Text(
              data,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle,
            );
          case NativeTextTheme.detail:
            return Text(
              data,
              style: Theme.of(context).textTheme.caption,
            );
          case NativeTextTheme.custom:
            return Text(
              data,
              style: style ?? Theme.of(context).textTheme.title,
            );
        }
        return Text(
          data,
          maxLines: maxLines,
          style: style,
        );
      },
      ios: (BuildContext context) {
        switch (type) {
          case NativeTextTheme.title:
            return Text(
              data,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                letterSpacing: -0.18,
              ),
            );
          case NativeTextTheme.subtitle:
            return Text(
              data,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15.0,
                letterSpacing: -0.24,
                color: CupertinoColors.inactiveGray,
              ),
            );
          case NativeTextTheme.detail:
            return Text(
              data,
              style: const TextStyle(
                color: CupertinoColors.inactiveGray,
                fontSize: 15.0,
                letterSpacing: -0.41,
              ),
            );
          case NativeTextTheme.custom:
            return Text(
              data,
              style: style ??
                  const TextStyle(
                    color: CupertinoColors.inactiveGray,
                    fontSize: 15.0,
                    letterSpacing: -0.41,
                  ),
            );
        }
      },
    );
  }
}
