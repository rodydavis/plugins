import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:data_tables/data_tables.dart';

void main() {
  const MethodChannel channel = MethodChannel('data_tables');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await DataTables.platformVersion, '42');
  });
}
