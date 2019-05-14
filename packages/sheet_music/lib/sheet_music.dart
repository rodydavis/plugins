library sheet_music;

import 'package:flutter/material.dart';

import 'util/clef_asset.dart';
import 'util/pitch_asset.dart';
import 'util/scale_asset.dart';

const String sheetMusicPackageName = "sheet_music";

/// Transparent Sheet Music View with [black] color.
class SheetMusic extends StatelessWidget {
  final bool trebleClef;
  final String pitch, scale;

  /// Hide the Sheet Music View.
  final bool hide;

  /// Color of the [background], everything else will be [black].
  /// Defaults to [transparent].
  final Color backgroundColor;

  /// Called when the [clef] section is tapped.
  final VoidCallback clefTap;

  /// Called when the [scale] section is tapped.
  final VoidCallback scaleTap;

  /// Called when the [note] section is tapped.
  final VoidCallback pitchTap;

  /// Specify a [height] and [width] for the view. Default [197x100].
  final double width, height;

  SheetMusic({
    @required this.trebleClef,
    @required this.scale,
    @required this.pitch,
    this.pitchTap,
    this.clefTap,
    this.scaleTap,
    this.backgroundColor,
    this.hide,
    this.width,
    this.height,
  });

  Widget _buildClef({double width, double height, bool dark = false}) {
    final double _width = width * 0.1979;
    if (dark) {
      return Container(
        child: InkWell(
          onTap: clefTap,
          child: SizedBox(
            height: height,
            width: _width,
            child: Image.asset(
              getClefAsset(trebleClef),
              package: sheetMusicPackageName,
              fit: BoxFit.fitWidth,
              colorBlendMode: BlendMode.srcATop,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    return Container(
      child: InkWell(
        onTap: clefTap,
        child: SizedBox(
          height: height,
          width: _width,
          child: Image.asset(
            getClefAsset(trebleClef),
            package: sheetMusicPackageName,
            fit: BoxFit.fitWidth,
            colorBlendMode: BlendMode.srcATop,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildScale({double width, double height, bool dark = false}) {
    final double _width = width * 0.5076;
    if (dark) {
      return Container(
        child: InkWell(
          onTap: scaleTap,
          child: SizedBox(
            height: height,
            width: _width,
            child: Image.asset(
              getScaleAsset(scale, trebleClef: trebleClef),
              package: sheetMusicPackageName,
              fit: BoxFit.fitWidth,
              colorBlendMode: BlendMode.srcATop,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    return Container(
      child: InkWell(
        onTap: scaleTap,
        child: SizedBox(
          height: height,
          width: _width,
          child: Image.asset(
            getScaleAsset(scale, trebleClef: trebleClef),
            package: sheetMusicPackageName,
            fit: BoxFit.fitWidth,
            colorBlendMode: BlendMode.srcATop,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildPitch({double width, double height, bool dark = false}) {
    final double _width = width * 0.2944;
    if (dark) {
      return Container(
        child: InkWell(
          onTap: pitchTap,
          child: SizedBox(
            height: height,
            width: _width,
            child: Image.asset(
              getPitchAsset(pitch, trebleClef: trebleClef),
              package: sheetMusicPackageName,
              fit: BoxFit.fitWidth,
              colorBlendMode: BlendMode.srcATop,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    return Container(
      child: InkWell(
        onTap: pitchTap,
        child: SizedBox(
          height: height,
          width: _width,
          child: Image.asset(
            getPitchAsset(pitch, trebleClef: trebleClef),
            package: sheetMusicPackageName,
            fit: BoxFit.fitWidth,
            colorBlendMode: BlendMode.srcATop,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (hide != null && hide) return Container();
    final double _width = ((height ?? 100.0) * 197.0) / 100.0;
    final double _height = ((width ?? 197.0) * 100.0) / 197.0;
    final bool dark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      child: SizedBox(
        width: _width,
        height: _height,
        child: Container(
          color: backgroundColor,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _buildClef(width: _width, height: _height, dark: dark),
                _buildScale(width: _width, height: _height, dark: dark),
                _buildPitch(width: _width, height: _height, dark: dark),
              ]),
        ),
      ),
    );
  }
}
