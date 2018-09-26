import 'assets.dart';

String getClefAsset(bool trebleClef) {
  if (trebleClef) return trebleClef_asset;
  return bassClef_asset;
}
