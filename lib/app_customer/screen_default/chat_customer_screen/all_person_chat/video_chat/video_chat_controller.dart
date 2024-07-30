// import 'dart:async';
// import 'package:custom_timer/custom_timer.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:get/get.dart';
// import 'package:sahashop_customer/app_customer/components/dialog/dialog.dart';
// import 'package:sahashop_customer/app_customer/const/const_calling.dart';
// import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
// import '../../../../model/calling.dart';
// import '../../../../utils/debounce.dart';
// import '../../../../utils/finish_handle_utils.dart';
// import '../signaling.dart';
//
// class VideoChatController extends GetxController {
//   Signaling signaling = Signaling();
//   var localRenderer = RTCVideoRenderer().obs;
//   var remoteRenderer = RTCVideoRenderer().obs;
//   String? roomId;
//   TextEditingController textEditingController = TextEditingController(text: '');
//   var accepted = false.obs;
//   Calling? callingInput;
//   var callingMain = Calling().obs;
//   var stateCall = ''.obs;
//   var cameraOnTo = false.obs;
//   var cameraOnFrom = false.obs;
//   var loading = true.obs;
//   var mic = true.obs;
//
//   CustomTimerController controllerTimer = CustomTimerController();
//   DataAppCustomerController dataAppCustomerController = Get.find();
//
//   VideoChatController({this.callingInput}) {
//     loading.value == true;
//     localRenderer.value.initialize();
//     remoteRenderer.value.initialize();
//     if (callingInput != null) {
//       print(
//           "check camera from on ==============================================${callingInput?.cameraFrom}");
//       print(
//           "check camera from on ==============================================${callingInput?.toId}");
//       callingMain.value = callingInput!;
//       cameraOnFrom.value = callingInput!.type == VIDEO ? true : false;
//       cameraOnTo.value = callingInput?.cameraTo ?? false;
//     }
//     loading.value == false;
//
//     dataAppCustomerController.calling.listen((calling) {
//       EasyDebounce.debounce('debounce_call', Duration(milliseconds: 500), () {
//         print("RUNNNNNNNNNNNNNNNNNNNNNNNNMNNNNNNNN");
//         if (calling.room != null) {
//           callingMain.value = calling;
//           if (calling.requesFrom == CAMERA && isUserTo() == true) {
//             SahaDialogApp.showDialogAcceptCamera(
//                 title: '${calling.name} đang yêu cầu camera ?',
//                 onOK: () {
//                   signaling.updateCall({'cameraTo': true, 'requesFrom': null},
//                       calling.toId ?? 0);
//                   cameraOnTo.value = true;
//                 },
//                 cancle: () {
//                   signaling.updateCall({'requesFrom': null}, calling.toId ?? 0);
//                 });
//           }
//           if (calling.requesTo == CAMERA && isUserTo() == false) {
//             SahaDialogApp.showDialogAcceptCamera(
//                 title:
//                     '${callingInput?.infoCustomerTo?.name ?? ""} đang yêu cầu camera ?',
//                 onOK: () {
//                   signaling.updateCall({'cameraFrom': true, 'requesTo': null},
//                       calling.toId ?? 0);
//                   cameraOnFrom.value = true;
//                 },
//                 cancle: () {
//                   signaling.updateCall({'requesTo': null}, calling.toId ?? 0);
//                 });
//           }
//
//           if (calling.state == DISCONNECTED &&
//               isUserTo() == true &&
//               stateCall.value == CONNECTING) {
//             Get.back();
//             dispose();
//           }
//
//           print(isUserTo());
//           print(calling.state);
//           print(stateCall.value);
//
//           if (calling.state == DISCONNECTED &&
//               isUserTo() == false &&
//               stateCall.value == '') {
//             Get.back();
//             dispose();
//           }
//         }
//       } // <-- The target method
//           );
//     });
//
//     if (callingInput?.infoCustomerTo != null) {
//       signaling
//           .openUserMedia(localRenderer.value, remoteRenderer.value)
//           .then((value) {
//         localRenderer.refresh();
//         remoteRenderer.refresh();
//       });
//     }
//
//     signaling.onAddRemoteStream = ((stream) {
//       remoteRenderer.value.srcObject = stream;
//
//       remoteRenderer.refresh();
//     });
//
//     signaling.onChangeState = (v) {
//       stateCall.value = v;
//       if (v == DISCONNECTED) {
//         Get.back(result: v);
//       }
//       if (v == CONNECTED) {
//         controllerTimer.start();
//       }
//     };
//
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       if (callingInput?.infoCustomerTo != null) {
//         roomId = await signaling.createRoom(
//             remoteRenderer: remoteRenderer.value,
//             customerIdInput: callingInput?.infoCustomerTo?.id ?? 0,
//             type: callingInput?.type);
//       }
//     });
//   }
//
//   bool isUserTo() {
//     print(">>>>>>>>>>>>>>>>>${callingMain.value.toId}");
//     if (callingMain.value.toId ==
//         dataAppCustomerController.infoCustomer.value.id) return true;
//     return false;
//   }
//
//   bool checkCameraBackgroundFrom() {
//     if (stateCall.value == '') {
//       if (cameraOnFrom.value == true) {
//         return true;
//       } else {
//         return false;
//       }
//     }
//
//     if (stateCall.value == CONNECTED) {
//       if (callingMain.value.cameraTo == true) {
//         return true;
//       } else {
//         return false;
//       }
//     }
//     return false;
//   }
//
//   Future<void> accetp({bool? accetpVideo}) async {
//     if (accetpVideo == true) {
//       signaling.updateCall({'cameraTo': true},
//           dataAppCustomerController.infoCustomer.value.id ?? 0);
//       cameraOnTo.value = true;
//     }
//
//     await signaling
//         .openUserMedia(
//       localRenderer.value,
//       remoteRenderer.value,
//     )
//         .then((value) {
//       localRenderer.refresh();
//       remoteRenderer.refresh();
//     });
//
//     await signaling.joinRoom(
//       callingInput?.room ?? "",
//       remoteRenderer.value,
//     );
//
//     accepted.value = true;
//   }
//
//   @override
//   void dispose() {
//     signaling.hangUp(localRenderer.value);
//     controllerTimer.dispose();
//     Get.delete<VideoChatController>();
//     EasyDebounce.cancel('debounce_call');
//     localRenderer.value.dispose();
//     remoteRenderer.value.dispose();
//     super.dispose();
//   }
//
//   void cancle() {
//     signaling.hangUp(localRenderer.value);
//   }
// }
