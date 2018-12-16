import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Native Loading Indicator
class NativeLoadingIndicator extends StatelessWidget {
  final Widget text;
  final bool center;

  NativeLoadingIndicator({Key key, this.text, this.center});

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS
        ? text == null
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
              )
        : text == null
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
              ));
  }
}