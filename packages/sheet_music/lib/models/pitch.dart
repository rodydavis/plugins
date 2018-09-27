import 'package:tonic/tonic.dart';

enum PitchType { c, d, f, g, a, b }

enum PitchTune { sharp, flat, natural }

class PitchInfo {
  final PitchType type;
  final PitchTune tune;

  PitchInfo({this.tune, this.type});

  PitchInfo.parse(Pitch pitch)
      : type = null,
        tune = _getTune(pitch.accidentalsString);

  static PitchTune _getTune(String pitch) {
    if (pitch.contains("#")) return PitchTune.sharp;
    if (pitch.contains("♯")) return PitchTune.sharp;
    if (pitch.contains("b")) return PitchTune.flat;
    if (pitch.contains("♭")) return PitchTune.flat;
    return PitchTune.natural;
  }
}
