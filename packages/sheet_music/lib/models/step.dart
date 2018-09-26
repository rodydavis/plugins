import 'scale.dart';

enum Step { DO, RE, MI, FA, SOL, LA, TI }

Step updateStep(String scale, String pitch) {
  // print("Scale: $scale, Pitch: $pitch");

  if (pitch == null) return Step.DO;
  if (scale == null) return Step.DO;

  final PossibleScales _scale = ScaleInfo.parse(scale).scale;

  switch (_scale) {
    case PossibleScales.cMajor:
      //C Major
      if (pitch.contains("C")) {
        return Step.DO;
      } else if (pitch.contains("D")) {
        return Step.RE;
      } else if (pitch.contains("E")) {
        return Step.MI;
      } else if (pitch.contains("F")) {
        return Step.FA;
      } else if (pitch.contains("G")) {
        return Step.SOL;
      } else if (pitch.contains("A")) {
        return Step.LA;
      } else if (pitch.contains("B")) {
        return Step.TI;
      }
      break;
    case PossibleScales.gMajor:
      //G Major
      if (pitch.contains("C")) {
        return Step.FA;
      } else if (pitch.contains("D")) {
        return Step.SOL;
      } else if (pitch.contains("E")) {
        return Step.LA;
      } else if (pitch.contains("F")) {
        return Step.TI;
      } else if (pitch.contains("G")) {
        return Step.DO;
      } else if (pitch.contains("A")) {
        return Step.RE;
      } else if (pitch.contains("B")) {
        return Step.MI;
      }
      break;
    case PossibleScales.dMajor:
      //D Major
      if (pitch.contains("C")) {
        return Step.TI;
      } else if (pitch.contains("D")) {
        return Step.DO;
      } else if (pitch.contains("E")) {
        return Step.RE;
      } else if (pitch.contains("F")) {
        return Step.MI;
      } else if (pitch.contains("G")) {
        return Step.FA;
      } else if (pitch.contains("A")) {
        return Step.SOL;
      } else if (pitch.contains("B")) {
        return Step.LA;
      }
      break;
    case PossibleScales.aMajor:
      //A Major
      if (pitch.contains("C")) {
        return Step.MI;
      } else if (pitch.contains("D")) {
        return Step.FA;
      } else if (pitch.contains("E")) {
        return Step.SOL;
      } else if (pitch.contains("F")) {
        return Step.LA;
      } else if (pitch.contains("G")) {
        return Step.TI;
      } else if (pitch.contains("A")) {
        return Step.DO;
      } else if (pitch.contains("B")) {
        return Step.RE;
      }
      break;
    case PossibleScales.eMajor:
      //E Major
      if (pitch.contains("C")) {
        return Step.LA;
      } else if (pitch.contains("D")) {
        return Step.TI;
      } else if (pitch.contains("E")) {
        return Step.DO;
      } else if (pitch.contains("F")) {
        return Step.RE;
      } else if (pitch.contains("G")) {
        return Step.MI;
      } else if (pitch.contains("A")) {
        return Step.FA;
      } else if (pitch.contains("B")) {
        return Step.SOL;
      }
      break;
    case PossibleScales.bMajor:
      //B Major
      if (pitch.contains("C")) {
        return Step.RE;
      } else if (pitch.contains("D")) {
        return Step.MI;
      } else if (pitch.contains("E")) {
        return Step.FA;
      } else if (pitch.contains("F")) {
        return Step.SOL;
      } else if (pitch.contains("G")) {
        return Step.LA;
      } else if (pitch.contains("A")) {
        return Step.TI;
      } else if (pitch.contains("B")) {
        return Step.DO;
      }
      break;
    case PossibleScales.fSMajor:
      //F# Major
      if (pitch.contains("C")) {
        return Step.SOL;
      } else if (pitch.contains("D")) {
        return Step.LA;
      } else if (pitch.contains("E")) {
        return Step.TI;
      } else if (pitch.contains("F")) {
        return Step.DO;
      } else if (pitch.contains("G")) {
        return Step.RE;
      } else if (pitch.contains("A")) {
        return Step.MI;
      } else if (pitch.contains("B")) {
        return Step.FA;
      }
      break;
    case PossibleScales.cSMajor:
      //C# Major
      if (pitch.contains("C")) {
        return Step.DO;
      } else if (pitch.contains("D")) {
        return Step.RE;
      } else if (pitch.contains("E")) {
        return Step.MI;
      } else if (pitch.contains("F")) {
        return Step.FA;
      } else if (pitch.contains("G")) {
        return Step.SOL;
      } else if (pitch.contains("A")) {
        return Step.LA;
      } else if (pitch.contains("B")) {
        return Step.TI;
      }
      break;
    case PossibleScales.fMajor:
      //F Major
      if (pitch.contains("C")) {
        return Step.SOL;
      } else if (pitch.contains("D")) {
        return Step.LA;
      } else if (pitch.contains("E")) {
        return Step.TI;
      } else if (pitch.contains("F")) {
        return Step.DO;
      } else if (pitch.contains("G")) {
        return Step.RE;
      } else if (pitch.contains("A")) {
        return Step.MI;
      } else if (pitch.contains("B")) {
        return Step.FA;
      }
      break;
    case PossibleScales.bbMajor:
      //Bb Major
      if (pitch.contains("C")) {
        return Step.RE;
      } else if (pitch.contains("D")) {
        return Step.MI;
      } else if (pitch.contains("E")) {
        return Step.FA;
      } else if (pitch.contains("F")) {
        return Step.SOL;
      } else if (pitch.contains("G")) {
        return Step.LA;
      } else if (pitch.contains("A")) {
        return Step.TI;
      } else if (pitch.contains("B")) {
        return Step.DO;
      }
      break;
    case PossibleScales.ebMajor:
      //Eb Major
      if (pitch.contains("C")) {
        return Step.LA;
      } else if (pitch.contains("D")) {
        return Step.TI;
      } else if (pitch.contains("E")) {
        return Step.DO;
      } else if (pitch.contains("F")) {
        return Step.RE;
      } else if (pitch.contains("G")) {
        return Step.MI;
      } else if (pitch.contains("A")) {
        return Step.FA;
      } else if (pitch.contains("B")) {
        return Step.SOL;
      }
      break;
    case PossibleScales.abMajor:
      //Ab Major
      if (pitch.contains("C")) {
        return Step.MI;
      } else if (pitch.contains("D")) {
        return Step.FA;
      } else if (pitch.contains("E")) {
        return Step.SOL;
      } else if (pitch.contains("F")) {
        return Step.LA;
      } else if (pitch.contains("G")) {
        return Step.TI;
      } else if (pitch.contains("A")) {
        return Step.DO;
      } else if (pitch.contains("B")) {
        return Step.RE;
      }
      break;
    case PossibleScales.dbMajor:
      //Db Major
      if (pitch.contains("C")) {
        return Step.TI;
      } else if (pitch.contains("D")) {
        return Step.DO;
      } else if (pitch.contains("E")) {
        return Step.RE;
      } else if (pitch.contains("F")) {
        return Step.MI;
      } else if (pitch.contains("G")) {
        return Step.FA;
      } else if (pitch.contains("A")) {
        return Step.SOL;
      } else if (pitch.contains("B")) {
        return Step.LA;
      }
      break;
    case PossibleScales.gbMajor:
      //Gb Major
      if (pitch.contains("C")) {
        return Step.FA;
      } else if (pitch.contains("D")) {
        return Step.SOL;
      } else if (pitch.contains("E")) {
        return Step.LA;
      } else if (pitch.contains("F")) {
        return Step.TI;
      } else if (pitch.contains("G")) {
        return Step.DO;
      } else if (pitch.contains("A")) {
        return Step.RE;
      } else if (pitch.contains("B")) {
        return Step.MI;
      }
      break;
    case PossibleScales.cbMajor:
      //Cb Major
      if (pitch.contains("C")) {
        return Step.DO;
      } else if (pitch.contains("D")) {
        return Step.RE;
      } else if (pitch.contains("E")) {
        return Step.MI;
      } else if (pitch.contains("F")) {
        return Step.FA;
      } else if (pitch.contains("G")) {
        return Step.SOL;
      } else if (pitch.contains("A")) {
        return Step.LA;
      } else if (pitch.contains("B")) {
        return Step.TI;
      }
      break;
  }
  return Step.DO;
}
