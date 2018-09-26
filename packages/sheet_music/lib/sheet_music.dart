library sheet_music;

import 'package:flutter/material.dart';

import 'models/scale.dart';
import 'util/sheet_music_assets.dart';

class SheetMusic extends StatelessWidget {
  final bool trebleClef;
  final PossibleScales scale;
  final String pitch;

  final VoidCallback clefTap;
  final VoidCallback scaleTap;
  final VoidCallback pitchTap;
  SheetMusic({
    @required this.trebleClef,
    @required this.clefTap,
    @required this.scaleTap,
    @required this.scale,
    @required this.pitch,
    @required this.pitchTap,
  });

  Widget _buildClef() {
    Widget _image;
    if (trebleClef) {
      _image = Image.asset(
        trebleClef_asset,
        fit: BoxFit.fitWidth,
      );
    } else {
      _image = Image.asset(
        bassClef_asset,
        fit: BoxFit.fitWidth,
      );
    }

    return Container(
      child: InkWell(
        onTap: clefTap,
        child: SizedBox(
          height: 100.0,
          width: 39.0,
          child: _image,
        ),
      ),
    );
  }

  Widget _buildScale() {
    if (trebleClef) {
      switch (scale) {
        case PossibleScales.cMajor:
          return _scaleImage(cmajor_treble_asset);
        case PossibleScales.gMajor:
          return _scaleImage(gmajor_treble_asset);
        case PossibleScales.dMajor:
          return _scaleImage(dmajor_treble_asset);
        case PossibleScales.aMajor:
          return _scaleImage(amajor_treble_asset);
        case PossibleScales.eMajor:
          return _scaleImage(emajor_treble_asset);
        case PossibleScales.bMajor:
          return _scaleImage(bmajor_treble_asset);
        case PossibleScales.fSMajor:
          return _scaleImage(fsmajor_treble_asset);
        case PossibleScales.cSMajor:
          return _scaleImage(csmajor_treble_asset);
        case PossibleScales.fMajor:
          return _scaleImage(fmajor_treble_asset);
        case PossibleScales.bbMajor:
          return _scaleImage(bbmajor_treble_asset);
        case PossibleScales.ebMajor:
          return _scaleImage(ebmajor_treble_asset);
        case PossibleScales.abMajor:
          return _scaleImage(abmajor_treble_asset);
        case PossibleScales.dbMajor:
          return _scaleImage(dbmajor_treble_asset);
        case PossibleScales.gbMajor:
          return _scaleImage(gbmajor_treble_asset);
        case PossibleScales.cbMajor:
          return _scaleImage(cbmajor_treble_asset);
      }
    }
    switch (scale) {
      case PossibleScales.cMajor:
        return _scaleImage(cmajor_bass_asset);
      case PossibleScales.gMajor:
        return _scaleImage(gmajor_bass_asset);
      case PossibleScales.dMajor:
        return _scaleImage(dmajor_bass_asset);
      case PossibleScales.aMajor:
        return _scaleImage(amajor_bass_asset);
      case PossibleScales.eMajor:
        return _scaleImage(emajor_bass_asset);
      case PossibleScales.bMajor:
        return _scaleImage(bmajor_bass_asset);
      case PossibleScales.fSMajor:
        return _scaleImage(fsmajor_bass_asset);
      case PossibleScales.cSMajor:
        return _scaleImage(csmajor_bass_asset);
      case PossibleScales.fMajor:
        return _scaleImage(fmajor_bass_asset);
      case PossibleScales.bbMajor:
        return _scaleImage(bbmajor_bass_asset);
      case PossibleScales.ebMajor:
        return _scaleImage(ebmajor_bass_asset);
      case PossibleScales.abMajor:
        return _scaleImage(abmajor_bass_asset);
      case PossibleScales.dbMajor:
        return _scaleImage(dbmajor_bass_asset);
      case PossibleScales.gbMajor:
        return _scaleImage(gbmajor_bass_asset);
      case PossibleScales.cbMajor:
        return _scaleImage(cbmajor_bass_asset);
    }
    // Default: C Major
    return _scaleImage(cmajor_bass_asset);
  }

  Widget _buildPitch() {
    if (trebleClef) {
      switch (pitch) {
        case "G3":
          return _pitchImage(g3_treble_asset);
        case "A3":
          return _pitchImage(a3_treble_asset);
        case "B3":
          return _pitchImage(b3_treble_asset);
        case "C4":
          return _pitchImage(c4_treble_asset);
        case "D4":
          return _pitchImage(d4_treble_asset);
        case "E4":
          return _pitchImage(e4_treble_asset);
        case "F4":
          return _pitchImage(f4_treble_asset);
        case "G4":
          return _pitchImage(g4_treble_asset);
        case "A4":
          return _pitchImage(a4_treble_asset);
        case "B4":
          return _pitchImage(b4_treble_asset);
        case "C5":
          return _pitchImage(c5_treble_asset);
        case "D5":
          return _pitchImage(d5_treble_asset);
        case "E5":
          return _pitchImage(e5_treble_asset);
        case "F5":
          return _pitchImage(f5_treble_asset);
        case "G5":
          return _pitchImage(g5_treble_asset);
        case "A5":
          return _pitchImage(a5_treble_asset);
        case "B5":
          return _pitchImage(b5_treble_asset);
        case "C6":
          return _pitchImage(c6_treble_asset);
        case "D6":
          return _pitchImage(d6_treble_asset);
        default:
          return _pitchImage(none_asset);
      }
    }
    switch (pitch) {
      case "B1":
        return _pitchImage(b1_bass_asset);
      case "C2":
        return _pitchImage(c2_bass_asset);
      case "D2":
        return _pitchImage(d2_bass_asset);
      case "E2":
        return _pitchImage(e2_bass_asset);
      case "F2":
        return _pitchImage(f2_bass_asset);
      case "G2":
        return _pitchImage(g2_bass_asset);
      case "A2":
        return _pitchImage(a2_bass_asset);
      case "B2":
        return _pitchImage(b2_bass_asset);
      case "C3":
        return _pitchImage(c3_bass_asset);
      case "D3":
        return _pitchImage(d3_bass_asset);
      case "E3":
        return _pitchImage(e3_bass_asset);
      case "F3":
        return _pitchImage(f3_bass_asset);
      case "G3":
        return _pitchImage(g3_bass_asset);
      case "A3":
        return _pitchImage(a3_bass_asset);
      case "B3":
        return _pitchImage(b3_bass_asset);
      case "C4":
        return _pitchImage(c4_bass_asset);
      case "D4":
        return _pitchImage(d4_bass_asset);
      case "E4":
        return _pitchImage(e4_bass_asset);
      case "F4":
        return _pitchImage(f4_bass_asset);
      default:
        return _pitchImage(none_asset);
    }
  }

  Widget _pitchImage(String url) {
    return Container(
      child: InkWell(
        onTap: pitchTap,
        child: SizedBox(
          height: 100.0,
          width: 58.0,
          child: Image.asset(
            url,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

  Widget _scaleImage(String url) {
    return Container(
      child: InkWell(
        onTap: scaleTap,
        child: SizedBox(
          height: 100.0,
          width: 100.0,
          child: Image.asset(
            url,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[_buildClef(), _buildScale(), _buildPitch()]);
  }
}
