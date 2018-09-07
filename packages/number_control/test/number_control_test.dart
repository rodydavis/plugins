import 'package:test/test.dart';

import 'package:number_control/number_control.dart';

void main() {
  test('adds one to input values', () {
    final NumberControl calculator = new NumberControl(
      defaultValue: 0,
      max: 2,
      min: 0,
      onChanged: (int value) {
        print(value);
      },
    );
    expect(calculator.max, 2);
    expect(calculator.min, 0);
  });
}
