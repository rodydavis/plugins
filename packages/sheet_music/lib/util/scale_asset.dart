import '../models/scale.dart';
import 'assets.dart';

String getScaleAsset(String scale, {bool trebleClef}) {
  final PossibleScales _scale = ScaleInfo.parse(scale).scale;
  if (trebleClef != null && trebleClef) {
    switch (_scale) {
      case PossibleScales.cMajor:
        return cmajor_treble_asset;
      case PossibleScales.gMajor:
        return gmajor_treble_asset;
      case PossibleScales.dMajor:
        return dmajor_treble_asset;
      case PossibleScales.aMajor:
        return amajor_treble_asset;
      case PossibleScales.eMajor:
        return emajor_treble_asset;
      case PossibleScales.bMajor:
        return bmajor_treble_asset;
      case PossibleScales.fSMajor:
        return fsmajor_treble_asset;
      case PossibleScales.cSMajor:
        return csmajor_treble_asset;
      case PossibleScales.fMajor:
        return fmajor_treble_asset;
      case PossibleScales.bbMajor:
        return bbmajor_treble_asset;
      case PossibleScales.ebMajor:
        return ebmajor_treble_asset;
      case PossibleScales.abMajor:
        return abmajor_treble_asset;
      case PossibleScales.dbMajor:
        return dbmajor_treble_asset;
      case PossibleScales.gbMajor:
        return gbmajor_treble_asset;
      case PossibleScales.cbMajor:
        return cbmajor_treble_asset;
    }
  }
  switch (_scale) {
    case PossibleScales.cMajor:
      return cmajor_bass_asset;
    case PossibleScales.gMajor:
      return gmajor_bass_asset;
    case PossibleScales.dMajor:
      return dmajor_bass_asset;
    case PossibleScales.aMajor:
      return amajor_bass_asset;
    case PossibleScales.eMajor:
      return emajor_bass_asset;
    case PossibleScales.bMajor:
      return bmajor_bass_asset;
    case PossibleScales.fSMajor:
      return fsmajor_bass_asset;
    case PossibleScales.cSMajor:
      return csmajor_bass_asset;
    case PossibleScales.fMajor:
      return fmajor_bass_asset;
    case PossibleScales.bbMajor:
      return bbmajor_bass_asset;
    case PossibleScales.ebMajor:
      return ebmajor_bass_asset;
    case PossibleScales.abMajor:
      return abmajor_bass_asset;
    case PossibleScales.dbMajor:
      return dbmajor_bass_asset;
    case PossibleScales.gbMajor:
      return gbmajor_bass_asset;
    case PossibleScales.cbMajor:
      return cbmajor_bass_asset;
  }
  // Default: C Major
  return cmajor_bass_asset;
}
