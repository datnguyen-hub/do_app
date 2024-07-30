// import 'package:flutter_test/flutter_test.dart';
// import 'package:sahashop_customer/sahashop_customer.dart';
// import 'package:sahashop_customer/sahashop_customer_platform_interface.dart';
// import 'package:sahashop_customer/sahashop_customer_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockSahashopCustomerPlatform
//     with MockPlatformInterfaceMixin
//     implements SahashopCustomerPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final SahashopCustomerPlatform initialPlatform = SahashopCustomerPlatform.instance;
//
//   test('$MethodChannelSahashopCustomer is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelSahashopCustomer>());
//   });
//
//   test('getPlatformVersion', () async {
//     SahashopCustomer sahashopCustomerPlugin = SahashopCustomer();
//     MockSahashopCustomerPlatform fakePlatform = MockSahashopCustomerPlatform();
//     SahashopCustomerPlatform.instance = fakePlatform;
//
//     expect(await sahashopCustomerPlugin.getPlatformVersion(), '42');
//   });
// }
