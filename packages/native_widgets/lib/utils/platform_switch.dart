part of native_widgets;

bool showCupertino({bool showMaterial = false}) {
  if (showMaterial != null && showMaterial) return false;
  if (Platform.isIOS) return true;
  if (Platform.isMacOS) return true;
  return false;
}
