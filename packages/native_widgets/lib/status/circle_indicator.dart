part of native_widgets;

// Native Loading Indicator
class NativeLoadingIndicator extends StatelessWidget {
  final Widget text;
  final bool center;
  final bool showMaterial;

  NativeLoadingIndicator({
    Key key,
    this.text,
    this.center,
    this.showMaterial = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool _isIos = showCupertino(showMaterial: showMaterial);

    if (_isIos) {
      return text == null
          ? center != null && center
              ? Center(
                  child: CupertinoActivityIndicator(
                    key: key,
                    animating: true,
                  ),
                )
              : CupertinoActivityIndicator(
                  key: key,
                  animating: true,
                )
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CupertinoActivityIndicator(
                    key: key,
                    animating: true,
                  ),
                  Container(
                    height: 10.0,
                  ),
                  text,
                ],
              ),
            );
    }
    return text == null
        ? center != null && center
            ? Center(
                child: CircularProgressIndicator(key: key),
              )
            : CircularProgressIndicator(key: key)
        : Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  key: key,
                ),
                Container(
                  height: 10.0,
                ),
                text,
              ],
            ),
          );
  }
}
