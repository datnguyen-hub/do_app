// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:custom_timer/custom_timer.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:get/get.dart';
// import '../../../../components/empty/saha_empty_avatar.dart';
// import '../../../../components/loading/loading_container.dart';
// import '../../../../components/widget/ripples_animation.dart';
// import '../../../../const/const_calling.dart';
// import '../../../../model/calling.dart';
// import '../../../data_app_controller.dart';
// import 'video_chat_controller.dart';
//
// class VideoChatScreen extends StatefulWidget {
//   Calling? callingInput;
//   VideoChatScreen({
//     this.callingInput,
//   });
//
//   @override
//   State<VideoChatScreen> createState() => _VideoChatScreenState();
// }
//
// class _VideoChatScreenState extends State<VideoChatScreen> {
//   late VideoChatController v;
//
//   DataAppCustomerController dataAppCustomerController = Get.find();
//
//   @override
//   void initState() {
//     v = VideoChatController(callingInput: widget.callingInput);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     v.signaling.hangUp(v.localRenderer.value);
//     v.localRenderer.value.dispose();
//     v.remoteRenderer.value.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => (v.accepted.value == false && v.isUserTo() == true)
//         ? callComming()
//         : v.isUserTo()
//             ? userTo()
//             : userFrom());
//   }
//
//   Widget callComming() {
//     return Stack(
//       children: [
//         Container(
//           height: Get.height,
//           width: Get.width,
//           color: Theme.of(context).primaryColor.withOpacity(0.9),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 15.0, right: 15.0),
//           child: Column(
//             children: [
//               Expanded(
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: MediaQuery.of(context).padding.top,
//                     ),
//                     Row(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             v.signaling
//                                 .rejectCall(v.callingMain.value.toId ?? 0);
//                             Get.back();
//                           },
//                           child: Container(
//                             height: 40,
//                             width: 40,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.black.withOpacity(0.5),
//                             ),
//                             child: Icon(Icons.arrow_back_ios_outlined,
//                                 size: 20, color: Colors.white),
//                           ),
//                         ),
//                         Spacer(),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         RippleAnimation(
//                           repeat: true,
//                           color: Colors.white,
//                           minRadius: 90,
//                           ripplesCount: 6,
//                           child: Container(
//                             margin: EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                     color:
//                                         Theme.of(Get.context!).primaryColor)),
//                             padding: EdgeInsets.all(5),
//                             child: ClipRRect(
//                               child: CachedNetworkImage(
//                                 imageUrl: widget.callingInput?.avatar ?? "",
//                                 width: Get.width / 2,
//                                 height: Get.width / 2,
//                                 fit: BoxFit.cover,
//                                 placeholder: (context, url) =>
//                                     SahaLoadingContainer(),
//                                 errorWidget: (context, url, error) =>
//                                     SahaEmptyAvata(
//                                   sizeIcon: 150,
//                                 ),
//                               ),
//                               borderRadius: BorderRadius.circular(3000),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           "${widget.callingInput?.name ?? ""}",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 25,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           "Đang gọi đến",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       v.signaling.rejectCall(v.callingMain.value.toId ?? 0);
//                       Get.back();
//                     },
//                     child: Container(
//                       height: 60,
//                       width: 60,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.red,
//                       ),
//                       child:
//                           Icon(Icons.call_end, size: 35, color: Colors.white),
//                     ),
//                   ),
//                   RippleAnimation(
//                     repeat: true,
//                     color: Colors.white,
//                     minRadius: 30,
//                     ripplesCount: 6,
//                     child: InkWell(
//                       onTap: () {
//                         v.accetp();
//                       },
//                       child: Container(
//                         height: 60,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.green,
//                         ),
//                         child: Icon(Icons.call, size: 30, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   if (widget.callingInput?.type == VIDEO)
//                     InkWell(
//                       onTap: () {
//                         v.accetp(accetpVideo: true);
//                       },
//                       child: Container(
//                         height: 60,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.green,
//                         ),
//                         child:
//                             Icon(Icons.videocam, size: 35, color: Colors.white),
//                       ),
//                     ),
//                 ],
//               ),
//               SizedBox(
//                 height: 50,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget userFrom() {
//     print("=====================> IS USER FROM");
//     return Obx(
//       () => Stack(
//         children: [
//           Container(
//             height: Get.height,
//             width: Get.width,
//             color: Theme.of(context).primaryColor.withOpacity(0.9),
//             child: v.loading.value
//                 ? null
//                 : v.cameraOnFrom.value == false
//                     ? null
//                     : Center(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Container(
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.white,
//                                 ),
//                                 padding: EdgeInsets.all(20),
//                                 child: Icon(
//                                   Icons.videocam_off_rounded,
//                                   color: Colors.grey,
//                                   size: 100,
//                                 )),
//                             TextButton(
//                               onPressed: () {
//                                 v.signaling.updateCall(
//                                     {'requesFrom': CAMERA},
//                                     widget.callingInput?.infoCustomerTo?.id ??
//                                         0);
//                               },
//                               child: Text(
//                                 "Yêu cầu camera",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//           ),
//           if (v.checkCameraBackgroundFrom())
//             SizedBox(
//                 height: Get.height,
//                 width: Get.width,
//                 child: Obx(
//                   () => RTCVideoView(
//                     v.stateCall.value == CONNECTED
//                         ? v.remoteRenderer.value
//                         : v.localRenderer.value,
//                     mirror: true,
//                     objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
//                   ),
//                 )),
//           Padding(
//             padding: const EdgeInsets.only(left: 15.0, right: 15.0),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: MediaQuery.of(context).padding.top + 10,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               Get.back();
//                             },
//                             child: Container(
//                               height: 40,
//                               width: 40,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Colors.black.withOpacity(0.5),
//                               ),
//                               child: Icon(Icons.arrow_back_ios_outlined,
//                                   size: 20, color: Colors.white),
//                             ),
//                           ),
//                           if (v.stateCall.value == CONNECTED)
//                             CustomTimer(
//                               controller: v.controllerTimer,
//                               begin: Duration(),
//                               end: Duration(days: 1),
//                               builder: (time) {
//                                 return Text(
//                                     "${time.hours} : ${time.minutes} : ${time.seconds}",
//                                     style: TextStyle(
//                                         fontSize: 20.0,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w500));
//                               },
//                             ),
//                           InkWell(
//                             onTap: () {
//                               if (v.stateCall.value == CONNECTED &&
//                                   v.cameraOnFrom.value == true) {
//                                 v.signaling.switchCamera();
//                               } else {
//                                 v.cameraOnFrom.value = true;
//                                 if (v.callingMain.value.cameraTo == false) {
//                                   v.signaling.updateCall(
//                                       {
//                                         'requesFrom': CAMERA,
//                                         'cameraFrom': true
//                                       },
//                                       widget.callingInput?.infoCustomerTo?.id ??
//                                           0);
//                                 } else {
//                                   v.signaling.updateCall(
//                                       {'cameraFrom': true},
//                                       widget.callingInput?.infoCustomerTo?.id ??
//                                           0);
//                                 }
//                               }
//                             },
//                             child: Container(
//                                 height: 40,
//                                 width: 40,
//                                 padding: const EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.black.withOpacity(0.5),
//                                 ),
//                                 child: Obx(
//                                   () => Icon(
//                                     v.stateCall.value == CONNECTED &&
//                                             v.cameraOnFrom.value == true
//                                         ? Icons.swap_horiz
//                                         : Icons.videocam,
//                                     color: Colors.white,
//                                   ),
//                                 )),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       if (v.cameraOnFrom.value == true)
//                         Obx(
//                           () => v.stateCall.value == CONNECTED
//                               ? Align(
//                                   alignment: Alignment.topRight,
//                                   child: Container(
//                                       color: Colors.white,
//                                       width: Get.width / 3,
//                                       height: (Get.width / 3) * 1.5,
//                                       child: Obx(
//                                         () => RTCVideoView(
//                                           v.localRenderer.value,
//                                           objectFit: RTCVideoViewObjectFit
//                                               .RTCVideoViewObjectFitCover,
//                                         ),
//                                       )),
//                                 )
//                               : Container(),
//                         ),
//                       Obx(
//                         () => v.stateCall.value != CONNECTED
//                             ? Column(
//                                 children: [
//                                   RippleAnimation(
//                                     repeat: true,
//                                     color: Colors.white,
//                                     minRadius: 90,
//                                     ripplesCount: 6,
//                                     child: Container(
//                                       margin: EdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           shape: BoxShape.circle,
//                                           border: Border.all(
//                                               color: Theme.of(Get.context!)
//                                                   .primaryColor)),
//                                       padding: EdgeInsets.all(5),
//                                       child: ClipRRect(
//                                         child: CachedNetworkImage(
//                                           imageUrl: widget
//                                                   .callingInput
//                                                   ?.infoCustomerTo
//                                                   ?.avatarImage ??
//                                               "",
//                                           width: Get.width / 2,
//                                           height: Get.width / 2,
//                                           fit: BoxFit.cover,
//                                           placeholder: (context, url) =>
//                                               SahaLoadingContainer(),
//                                           errorWidget: (context, url, error) =>
//                                               SahaEmptyAvata(
//                                             sizeIcon: 150,
//                                           ),
//                                         ),
//                                         borderRadius:
//                                             BorderRadius.circular(3000),
//                                       ),
//                                     ),
//                                   ),
//                                   Text(
//                                     "${widget.callingInput?.infoCustomerTo?.name ?? ""}",
//                                     style: TextStyle(
//                                         fontSize: 25,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text(
//                                     v.stateCall.value == CONNECTING
//                                         ? 'Đang kết nối'
//                                         : "Đang đổ chuông",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ],
//                               )
//                             : Container(),
//                       ),
//                       Obx(
//                         () => v.stateCall.value == CONNECTED &&
//                                 v.cameraOnFrom.value == false
//                             ? Column(
//                                 children: [
//                                   RippleAnimation(
//                                     repeat: v.stateCall.value == CONNECTED
//                                         ? false
//                                         : true,
//                                     color: Colors.white,
//                                     minRadius: 90,
//                                     ripplesCount: 6,
//                                     child: Container(
//                                       margin: EdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           shape: BoxShape.circle,
//                                           border: Border.all(
//                                               color: Theme.of(Get.context!)
//                                                   .primaryColor)),
//                                       padding: EdgeInsets.all(5),
//                                       child: ClipRRect(
//                                         child: CachedNetworkImage(
//                                           imageUrl: widget.callingInput
//                                                       ?.infoCustomerTo !=
//                                                   null
//                                               ? widget
//                                                       .callingInput
//                                                       ?.infoCustomerTo
//                                                       ?.avatarImage ??
//                                                   ""
//                                               : widget.callingInput?.avatar ??
//                                                   "",
//                                           width: Get.width / 2,
//                                           height: Get.width / 2,
//                                           fit: BoxFit.cover,
//                                           placeholder: (context, url) =>
//                                               SahaLoadingContainer(),
//                                           errorWidget: (context, url, error) =>
//                                               SahaEmptyAvata(
//                                             sizeIcon: 150,
//                                           ),
//                                         ),
//                                         borderRadius:
//                                             BorderRadius.circular(3000),
//                                       ),
//                                     ),
//                                   ),
//                                   Text(
//                                     widget.callingInput?.infoCustomerTo?.name ??
//                                         "",
//                                     style: TextStyle(
//                                         fontSize: 25,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text(
//                                     v.stateCall.value == CONNECTING
//                                         ? 'Đang kết nối'
//                                         : v.stateCall.value == CONNECTED
//                                             ? "Đang gọi"
//                                             : "Đang đổ chuông",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ],
//                               )
//                             : Container(),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         if (v.cameraOnFrom.value == true) {
//                           v.cameraOnFrom.value = false;
//                           v.signaling.updateCall({'cameraFrom': false},
//                               widget.callingInput?.infoCustomerTo?.id ?? 0);
//                         } else {}
//                       },
//                       child: Container(
//                         height: 60,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.black.withOpacity(0.5),
//                         ),
//                         child: Icon(
//                             v.cameraOnFrom.value == true
//                                 ? Icons.videocam
//                                 : Icons.volume_up_rounded,
//                             size: 35,
//                             color: Colors.white),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         v.cancle();
//                         Get.back();
//                       },
//                       child: Container(
//                         height: 60,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.red.withOpacity(0.9),
//                         ),
//                         child:
//                             Icon(Icons.call_end, size: 30, color: Colors.white),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         if (v.stateCall.value == CONNECTED) {
//                           v.mic.value = v.signaling.muteMic();
//                           print(v.mic.value);
//                         }
//                       },
//                       child: Obx(
//                         () => Container(
//                           height: 60,
//                           width: 60,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: !v.mic.value
//                                 ? Colors.black12
//                                 : Colors.black.withOpacity(0.5),
//                           ),
//                           child: Icon(Icons.mic,
//                               size: 35,
//                               color:
//                                   !v.mic.value ? Colors.white24 : Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 100,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget userTo() {
//     print("=====================> IS USER TO");
//     return Obx(
//       () => Stack(
//         children: [
//           Container(
//             height: Get.height,
//             width: Get.width,
//             color: Theme.of(context).primaryColor.withOpacity(0.9),
//             child: v.cameraOnTo.value == false
//                 ? null
//                 : Center(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Container(
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.white,
//                             ),
//                             padding: EdgeInsets.all(20),
//                             child: Icon(
//                               Icons.videocam_off_rounded,
//                               color: Colors.grey,
//                               size: 100,
//                             )),
//                         TextButton(
//                           onPressed: () {
//                             v.signaling.updateCall({'requesTo': CAMERA},
//                                 v.callingMain.value.toId ?? 0);
//                           },
//                           child: Text(
//                             "Yêu cầu camera",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//           ),
//           if (v.callingMain.value.cameraFrom == true)
//             SizedBox(
//                 height: Get.height,
//                 width: Get.width,
//                 child: Obx(
//                   () => RTCVideoView(
//                     v.remoteRenderer.value,
//                     mirror: true,
//                     objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
//                   ),
//                 )),
//           Padding(
//             padding: const EdgeInsets.only(left: 15.0, right: 15.0),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: MediaQuery.of(context).padding.top + 10,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               Get.back();
//                             },
//                             child: Container(
//                               height: 40,
//                               width: 40,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Colors.black.withOpacity(0.5),
//                               ),
//                               child: Icon(Icons.arrow_back_ios_outlined,
//                                   size: 20, color: Colors.white),
//                             ),
//                           ),
//                           if (v.stateCall.value == CONNECTED)
//                             CustomTimer(
//                               controller: v.controllerTimer,
//                               begin: Duration(),
//                               end: Duration(days: 1),
//                               builder: (time) {
//                                 return Text(
//                                     "${time.hours} : ${time.minutes} : ${time.seconds}",
//                                     style: TextStyle(
//                                         fontSize: 20.0,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w500));
//                               },
//                             ),
//                           InkWell(
//                             onTap: () {
//                               if (v.stateCall.value == CONNECTED &&
//                                   v.cameraOnTo.value == true) {
//                                 v.signaling.switchCamera();
//                               } else {
//                                 v.cameraOnTo.value = true;
//                                 if (v.callingMain.value.cameraFrom == false) {
//                                   v.signaling.updateCall(
//                                       {'requesTo': CAMERA, 'cameraTo': true},
//                                       v.callingMain.value.toId ?? 0);
//                                 } else {
//                                   v.signaling.updateCall({'cameraTo': true},
//                                       v.callingMain.value.toId ?? 0);
//                                 }
//                               }
//                             },
//                             child: Container(
//                                 height: 40,
//                                 width: 40,
//                                 padding: const EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.black.withOpacity(0.5),
//                                 ),
//                                 child: Obx(
//                                   () => Icon(
//                                     v.stateCall.value == CONNECTED &&
//                                             v.cameraOnTo.value == true
//                                         ? Icons.swap_horiz
//                                         : Icons.videocam,
//                                     color: Colors.white,
//                                   ),
//                                 )),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       if (v.cameraOnTo.value == true)
//                         Obx(
//                           () => v.stateCall.value == CONNECTED
//                               ? Align(
//                                   alignment: Alignment.topRight,
//                                   child: Container(
//                                       color: Colors.white,
//                                       width: Get.width / 3,
//                                       height: (Get.width / 3) * 1.5,
//                                       child: Obx(
//                                         () => RTCVideoView(
//                                           v.localRenderer.value,
//                                           objectFit: RTCVideoViewObjectFit
//                                               .RTCVideoViewObjectFitCover,
//                                         ),
//                                       )),
//                                 )
//                               : Container(),
//                         ),
//                       Obx(
//                         () => v.stateCall.value != CONNECTED
//                             ? Column(
//                                 children: [
//                                   RippleAnimation(
//                                     repeat: true,
//                                     color: Colors.white,
//                                     minRadius: 90,
//                                     ripplesCount: 6,
//                                     child: Container(
//                                       margin: EdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           shape: BoxShape.circle,
//                                           border: Border.all(
//                                               color: Theme.of(Get.context!)
//                                                   .primaryColor)),
//                                       padding: EdgeInsets.all(5),
//                                       child: ClipRRect(
//                                         child: CachedNetworkImage(
//                                           imageUrl:
//                                               v.callingMain.value.avatar ?? "",
//                                           width: Get.width / 2,
//                                           height: Get.width / 2,
//                                           fit: BoxFit.cover,
//                                           placeholder: (context, url) =>
//                                               SahaLoadingContainer(),
//                                           errorWidget: (context, url, error) =>
//                                               SahaEmptyAvata(
//                                             sizeIcon: 150,
//                                           ),
//                                         ),
//                                         borderRadius:
//                                             BorderRadius.circular(3000),
//                                       ),
//                                     ),
//                                   ),
//                                   Text(
//                                     "${v.callingMain.value.name ?? ""}",
//                                     style: TextStyle(
//                                         fontSize: 25,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text(
//                                     v.stateCall.value == CONNECTING
//                                         ? 'Đang kết nối'
//                                         : "Đang đổ chuông",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ],
//                               )
//                             : Container(),
//                       ),
//                       Obx(() {
//                         print(
//                             "check camera from on ==============================================${v.callingMain.value.cameraFrom}");
//                         return v.stateCall.value == CONNECTED &&
//                                 v.cameraOnTo.value == false
//                             ? Column(
//                                 children: [
//                                   RippleAnimation(
//                                     repeat: v.stateCall.value == CONNECTED
//                                         ? false
//                                         : true,
//                                     color: Colors.white,
//                                     minRadius: 90,
//                                     ripplesCount: 6,
//                                     child: Container(
//                                       margin: EdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           shape: BoxShape.circle,
//                                           border: Border.all(
//                                               color: Theme.of(Get.context!)
//                                                   .primaryColor)),
//                                       padding: EdgeInsets.all(5),
//                                       child: ClipRRect(
//                                         child: CachedNetworkImage(
//                                           imageUrl: widget.callingInput
//                                                       ?.infoCustomerTo !=
//                                                   null
//                                               ? widget
//                                                       .callingInput
//                                                       ?.infoCustomerTo
//                                                       ?.avatarImage ??
//                                                   ""
//                                               : widget.callingInput?.avatar ??
//                                                   "",
//                                           width: Get.width / 2,
//                                           height: Get.width / 2,
//                                           fit: BoxFit.cover,
//                                           placeholder: (context, url) =>
//                                               SahaLoadingContainer(),
//                                           errorWidget: (context, url, error) =>
//                                               SahaEmptyAvata(
//                                             sizeIcon: 150,
//                                           ),
//                                         ),
//                                         borderRadius:
//                                             BorderRadius.circular(3000),
//                                       ),
//                                     ),
//                                   ),
//                                   Text(
//                                     widget.callingInput?.infoCustomerTo != null
//                                         ? "${widget.callingInput?.infoCustomerTo?.name ?? ""}"
//                                         : "${widget.callingInput?.name ?? ""}",
//                                     style: TextStyle(
//                                         fontSize: 25,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text(
//                                     v.stateCall.value == CONNECTING
//                                         ? 'Đang kết nối'
//                                         : v.stateCall.value == CONNECTED
//                                             ? "Đang gọi"
//                                             : "Đang đổ chuông",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ],
//                               )
//                             : Container();
//                       }),
//                       SizedBox(
//                         height: 10,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         if (v.cameraOnTo.value == true) {
//                           v.cameraOnTo.value = false;
//                           v.signaling.updateCall({'cameraTo': false},
//                               v.callingMain.value.toId ?? 0);
//                         } else {}
//                       },
//                       child: Container(
//                         height: 60,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.black.withOpacity(0.5),
//                         ),
//                         child: Icon(
//                             v.cameraOnTo.value == true
//                                 ? Icons.videocam
//                                 : Icons.volume_up_rounded,
//                             size: 35,
//                             color: Colors.white),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: Container(
//                         height: 60,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.red.withOpacity(0.9),
//                         ),
//                         child:
//                             Icon(Icons.call_end, size: 30, color: Colors.white),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         if (v.stateCall.value == CONNECTED) {
//                           v.mic.value = v.signaling.muteMic();
//                           print(v.mic.value);
//                         }
//                       },
//                       child: Obx(
//                         () => Container(
//                           height: 60,
//                           width: 60,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: !v.mic.value
//                                 ? Colors.black12
//                                 : Colors.black.withOpacity(0.5),
//                           ),
//                           child: Icon(Icons.mic,
//                               size: 35,
//                               color:
//                                   !v.mic.value ? Colors.white24 : Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 100,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
