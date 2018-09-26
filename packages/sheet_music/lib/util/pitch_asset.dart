import 'assets.dart';

String getPitchAsset(String name, {bool trebleClef}) {
  final String pitch = name;
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
