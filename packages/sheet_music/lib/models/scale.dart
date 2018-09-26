import 'package:tonic/tonic.dart';

enum PossibleScales {
  cMajor,
  gMajor,
  dMajor,
  aMajor,
  eMajor,
  bMajor,
  fSMajor,
  cSMajor,
  fMajor,
  bbMajor,
  ebMajor,
  abMajor,
  dbMajor,
  gbMajor,
  cbMajor,
}

class ScaleInfo {
  final PossibleScales scale;
  final String name, pattern, note;

  ScaleInfo({this.scale, this.name, this.pattern, this.note});

  ScaleInfo.parse(String name)
      : scale = _getScale(name),
        pattern = _getPattern(name),
        note = _getNote(name),
        name = name.toString();

  static String _getNote(String name) {
    if (name.isEmpty) return "";
    String _note = name.trim();
    _note = _note.replaceAll(" ", "");
    _note = _note.toLowerCase().replaceAll("major", "");
    _note = _note.toLowerCase().replaceAll("minor", "");
    _note = _note.toUpperCase();
    return _note;
  }

  static String _getPattern(String name) {
    if (name.toLowerCase().contains('major')) return 'Diatonic Major';
    if (name.toLowerCase().contains('minor')) return 'Harmonic Minor';
    return 'Diatonic Major';
  }

  static PossibleScales _getScale(String name) {
    switch (name) {
      case "C Major":
        return PossibleScales.cMajor;
      case "G Major":
        return PossibleScales.gMajor;
      case "D Major":
        return PossibleScales.dMajor;
      case "A Major":
        return PossibleScales.aMajor;
      case "E Major":
        return PossibleScales.eMajor;
      case "B Major":
        return PossibleScales.bMajor;
      case "F# Major":
        return PossibleScales.fSMajor;
      case "C# Major":
        return PossibleScales.cSMajor;
      case "F Major":
        return PossibleScales.fMajor;
      case "Bb Major":
      case "B♭ Major":
        return PossibleScales.bbMajor;
      case "Eb Major":
      case "E♭ Major":
        return PossibleScales.ebMajor;
      case "Ab Major":
      case "A♭ Major":
        return PossibleScales.abMajor;
      case "Db Major":
      case "D♭ Major":
        return PossibleScales.dbMajor;
      case "Gb Major":
      case "G♭ Major":
        return PossibleScales.gbMajor;
      case "Cb Major":
      case "C♭ Major":
        return PossibleScales.cbMajor;
    }
    return PossibleScales.cMajor;
  }
}

Scale getScale(String scaleName) {
  final ScaleInfo _currentScale = ScaleInfo.parse(scaleName);
  final ScalePattern scalePattern =
      ScalePattern.findByName(_currentScale?.pattern);
  return scalePattern.at(PitchClass.parse(_currentScale?.note));
}
