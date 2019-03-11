import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:floating_search_bar/floating_search_bar.dart';

void main() {
  const MethodChannel channel = MethodChannel('floating_search_bar');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FloatingSearchBar.platformVersion, '42');
  });
}
