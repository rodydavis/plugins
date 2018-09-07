import 'package:native_widgets/native_widgets.dart';
import 'package:test/test.dart';

void main() {
  test('Checks for Not Null', () {
    final NativeButton button = new NativeButton();
    expect(button.child, !null);
  });
}
