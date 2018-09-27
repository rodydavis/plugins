import 'package:flutter/material.dart';

import '../models/scale.dart';
import 'assets.dart';

String getPitchAsset(String name, {bool trebleClef}) {
  String pitch = name;
  pitch = pitch.replaceAll("♯", "");
  pitch = pitch.replaceAll("#", "");
  pitch = pitch.replaceAll("b", "");
  pitch = pitch.replaceAll("♭", "");
  if (trebleClef != null && trebleClef) {
    switch (pitch) {
      case "G3":
        return g3_treble_asset;
      case "A3":
        return a3_treble_asset;
      case "B3":
        return b3_treble_asset;
      case "C4":
        return c4_treble_asset;
      case "D4":
        return d4_treble_asset;
      case "E4":
        return e4_treble_asset;
      case "F4":
        return f4_treble_asset;
      case "G4":
        return g4_treble_asset;
      case "A4":
        return a4_treble_asset;
      case "B4":
        return b4_treble_asset;
      case "C5":
        return c5_treble_asset;
      case "D5":
        return d5_treble_asset;
      case "E5":
        return e5_treble_asset;
      case "F5":
        return f5_treble_asset;
      case "G5":
        return g5_treble_asset;
      case "A5":
        return a5_treble_asset;
      case "B5":
        return b5_treble_asset;
      case "C6":
        return c6_treble_asset;
      case "D6":
        return d6_treble_asset;
      default:
        return none_asset;
    }
  }
  switch (pitch) {
    case "B1":
      return b1_bass_asset;
    case "C2":
      return c2_bass_asset;
    case "D2":
      return d2_bass_asset;
    case "E2":
      return e2_bass_asset;
    case "F2":
      return f2_bass_asset;
    case "G2":
      return g2_bass_asset;
    case "A2":
      return a2_bass_asset;
    case "B2":
      return b2_bass_asset;
    case "C3":
      return c3_bass_asset;
    case "D3":
      return d3_bass_asset;
    case "E3":
      return e3_bass_asset;
    case "F3":
      return f3_bass_asset;
    case "G3":
      return g3_bass_asset;
    case "A3":
      return a3_bass_asset;
    case "B3":
      return b3_bass_asset;
    case "C4":
      return c4_bass_asset;
    case "D4":
      return d4_bass_asset;
    case "E4":
      return e4_bass_asset;
    case "F4":
      return f4_bass_asset;
    default:
      return none_asset;
  }
}

String getPitchName({String scale, @required String pitch}) {
  final PossibleScales _scale = ScaleInfo.parse(scale ?? "C Major").scale;
  switch (_scale) {
    case PossibleScales.cMajor:
      //C Major
      break;
    case PossibleScales.gMajor:
      //G Major
      if (pitch.contains("F")) return pitch.replaceAll("F", "F#");
      break;
    case PossibleScales.dMajor:
      //D Major
      if (pitch.contains("F")) return pitch.replaceAll("F", "F#");
      if (pitch.contains("C")) return pitch.replaceAll("C", "C#");
      break;
    case PossibleScales.aMajor:
      //A Major
      if (pitch.contains("F")) return pitch.replaceAll("F", "F#");
      if (pitch.contains("C")) return pitch.replaceAll("C", "C#");
      if (pitch.contains("G")) return pitch.replaceAll("G", "G#");
      break;
    case PossibleScales.eMajor:
      //E Major
      if (pitch.contains("F")) return pitch.replaceAll("F", "F#");
      if (pitch.contains("C")) return pitch.replaceAll("C", "C#");
      if (pitch.contains("G")) return pitch.replaceAll("G", "G#");
      if (pitch.contains("D")) return pitch.replaceAll("D", "D#");
      break;
    case PossibleScales.bMajor:
      //B Major
      if (pitch.contains("F")) return pitch.replaceAll("F", "F#");
      if (pitch.contains("C")) return pitch.replaceAll("C", "C#");
      if (pitch.contains("G")) return pitch.replaceAll("G", "G#");
      if (pitch.contains("D")) return pitch.replaceAll("D", "D#");
      if (pitch.contains("A")) return pitch.replaceAll("A", "A#");
      break;
    case PossibleScales.fSMajor:
      //F# Major
      if (pitch.contains("F")) return pitch.replaceAll("F", "F#");
      if (pitch.contains("C")) return pitch.replaceAll("C", "C#");
      if (pitch.contains("G")) return pitch.replaceAll("G", "G#");
      if (pitch.contains("D")) return pitch.replaceAll("D", "D#");
      if (pitch.contains("A")) return pitch.replaceAll("A", "A#");
      if (pitch.contains("E")) return pitch.replaceAll("E", "E#");
      break;
    case PossibleScales.cSMajor:
      //C# Major
      if (pitch.contains("F")) return pitch.replaceAll("F", "F#");
      if (pitch.contains("C")) return pitch.replaceAll("C", "C#");
      if (pitch.contains("G")) return pitch.replaceAll("G", "G#");
      if (pitch.contains("D")) return pitch.replaceAll("D", "D#");
      if (pitch.contains("A")) return pitch.replaceAll("A", "A#");
      if (pitch.contains("E")) return pitch.replaceAll("E", "E#");
      if (pitch.contains("B")) return pitch.replaceAll("B", "B#");
      break;
    case PossibleScales.fMajor:
      //F Major
      if (pitch.contains("B")) return pitch.replaceAll("B", "B♭");
      break;
    case PossibleScales.bbMajor:
      //Bb Major
      if (pitch.contains("B")) return pitch.replaceAll("B", "B♭");
      if (pitch.contains("E")) return pitch.replaceAll("E", "E♭");
      break;
    case PossibleScales.ebMajor:
      //Eb Major
      if (pitch.contains("B")) return pitch.replaceAll("B", "B♭");
      if (pitch.contains("E")) return pitch.replaceAll("E", "E♭");
      if (pitch.contains("A")) return pitch.replaceAll("A", "A♭");
      break;
    case PossibleScales.abMajor:
      //Ab Major
      if (pitch.contains("B")) return pitch.replaceAll("B", "B♭");
      if (pitch.contains("E")) return pitch.replaceAll("E", "E♭");
      if (pitch.contains("A")) return pitch.replaceAll("A", "A♭");
      if (pitch.contains("D")) return pitch.replaceAll("D", "D♭");
      break;
    case PossibleScales.dbMajor:
      //Db Major
      if (pitch.contains("B")) return pitch.replaceAll("B", "B♭");
      if (pitch.contains("E")) return pitch.replaceAll("E", "E♭");
      if (pitch.contains("A")) return pitch.replaceAll("A", "A♭");
      if (pitch.contains("D")) return pitch.replaceAll("D", "D♭");
      if (pitch.contains("G")) return pitch.replaceAll("G", "G♭");
      break;
    case PossibleScales.gbMajor:
      //Gb Major
      if (pitch.contains("B")) return pitch.replaceAll("B", "B♭");
      if (pitch.contains("E")) return pitch.replaceAll("E", "E♭");
      if (pitch.contains("A")) return pitch.replaceAll("A", "A♭");
      if (pitch.contains("D")) return pitch.replaceAll("D", "D♭");
      if (pitch.contains("G")) return pitch.replaceAll("G", "G♭");
      if (pitch.contains("C")) return pitch.replaceAll("C", "C♭");
      break;
    case PossibleScales.cbMajor:
      //Cb Major
      if (pitch.contains("B")) return pitch.replaceAll("B", "B♭");
      if (pitch.contains("E")) return pitch.replaceAll("E", "E♭");
      if (pitch.contains("A")) return pitch.replaceAll("A", "A♭");
      if (pitch.contains("D")) return pitch.replaceAll("D", "D♭");
      if (pitch.contains("G")) return pitch.replaceAll("G", "G♭");
      if (pitch.contains("C")) return pitch.replaceAll("C", "C♭");
      if (pitch.contains("F")) return pitch.replaceAll("F", "F♭");
      break;
  }
  return pitch;
}
