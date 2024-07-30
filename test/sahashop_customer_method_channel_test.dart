// import 'package:flutter/services.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:sahashop_customer/sahashop_customer_method_channel.dart';
//
// void main() {
//   MethodChannelSahashopCustomer platform = MethodChannelSahashopCustomer();
//   const MethodChannel channel = MethodChannel('sahashop_customer');
//
//   TestWidgetsFlutterBinding.ensureInitialized();
//
//   setUp(() {
//     channel.setMockMethodCallHandler((MethodCall methodCall) async {
//       return '42';
//     });
//   });
//
//   tearDown(() {
//     channel.setMockMethodCallHandler(null);
//   });
//
//   test('getPlatformVersion', () async {
//     expect(await platform.getPlatformVersion(), '42');
//   });
// }
