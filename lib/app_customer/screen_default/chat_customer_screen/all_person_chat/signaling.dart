// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:get/get.dart' as getx;
// import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
//
// import '../../../const/const_calling.dart';
//
// typedef void StreamStateCallback(MediaStream stream);
//
// class Signaling {
//   Map<String, dynamic> configuration = {
//     'iceServers': [
//       {
//         'urls': [
//           'stun:stun1.l.google.com:19302',
//           'stun:stun2.l.google.com:19302'
//         ]
//       }
//     ]
//   };
//
//   RTCPeerConnection? peerConnection;
//   MediaStream? localStream;
//   MediaStream? remoteStream;
//   String? roomId;
//   int? customerId;
//   String? currentRoomText;
//   StreamStateCallback? onAddRemoteStream;
//   RTCRtpSender? _videoSender;
//   RTCRtpSender? _audioSender;
//   Function? onChangeState;
//   DataAppCustomerController dataAppCustomerController = getx.Get.find();
//
//   FirebaseFirestore db = FirebaseFirestore.instance;
//
//   Future<void> updateCall(data , int customerIdInput,) async {
//     print("update Call =========================> $data $customerIdInput");
//     DocumentReference allCall = db.collection('all_call').doc('$customerIdInput');
//     await allCall.update(data);
//   }
//
//   Future<void> rejectCall(int customerIdInput,) async {
//     print("reject Call =========================> $customerIdInput");
//     DocumentReference allCall = db.collection('all_call').doc('$customerIdInput');
//     await allCall.delete();
//   }
//
//   Future<String> createRoom(
//       {required RTCVideoRenderer remoteRenderer,
//       required int customerIdInput,
//       String? type}) async {
//     DocumentReference roomRef = db.collection('rooms').doc();
//     DocumentReference allCall =
//         db.collection('all_call').doc('$customerIdInput');
//     customerId = customerIdInput;
//     print('Create PeerConnection with configuration: $configuration');
//
//     peerConnection = await createPeerConnection(configuration);
//
//     registerPeerConnectionListeners();
//
//     localStream?.getTracks().forEach((track) {
//       peerConnection?.addTrack(track, localStream!);
//     });
//
//     // Code for collecting ICE candidates below
//     var callerCandidatesCollection = roomRef.collection('callerCandidates');
//
//     peerConnection?.onIceCandidate = (RTCIceCandidate candidate) {
//       print('Got candidate: ${candidate.toMap()}');
//       callerCandidatesCollection.add(candidate.toMap());
//     };
//     // Finish Code for collecting ICE candidate
//
//     // Add code for creating a room
//     RTCSessionDescription offer = await peerConnection!.createOffer();
//     await peerConnection!.setLocalDescription(offer);
//     print('Created offer: $offer');
//
//     Map<String, dynamic> roomWithOffer = {'offer': offer.toMap()};
//
//     await roomRef.set(roomWithOffer);
//     roomId = roomRef.id;
//     await allCall.set({
//       'toId': customerId,
//       'fromId': dataAppCustomerController.infoCustomer.value.id,
//       'avatar': dataAppCustomerController.infoCustomer.value.avatarImage ?? "",
//       'name': dataAppCustomerController.infoCustomer.value.name ?? "",
//       'room': roomId,
//       'type': type,
//       'cameraFrom': type == VIDEO ? true : false,
//       'cameraTo': false,
//       'requesFrom': null,
//       'requesTo': null,
//       'acceptFrom': false,
//       'acceptTo': false,
//     });
//
//     print('New room created with SDK offer. Room ID: $roomId');
//     currentRoomText = 'Current room is $roomId - You are the caller!';
//     // Created a Room
//
//     peerConnection?.onTrack = (RTCTrackEvent event) {
//       print('Got remote track: ${event.streams[0]}');
//
//       event.streams[0].getTracks().forEach((track) {
//         print('Add a track to the remoteStream $track');
//         remoteStream?.addTrack(track);
//       });
//     };
//
//     // Listening for remote session description below
//     roomRef.snapshots().listen((snapshot) async {
//       print('Got updated room: ${snapshot.data()}');
//
//       Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
//       if (peerConnection?.getRemoteDescription() != null &&
//           data['answer'] != null) {
//         var answer = RTCSessionDescription(
//           data['answer']['sdp'],
//           data['answer']['type'],
//         );
//
//         print(
//             "Someone tried to connect ====== ========= ====== = = = = = = = = = = =");
//         await peerConnection?.setRemoteDescription(answer);
//       }
//     });
//     // Listening for remote session description above
//
//     // Listen for remote Ice candidates below
//     roomRef.collection('calleeCandidates').snapshots().listen((snapshot) {
//       snapshot.docChanges.forEach((change) {
//         if (change.type == DocumentChangeType.added) {
//           Map<String, dynamic> data = change.doc.data() as Map<String, dynamic>;
//           print('Got new remote ICE candidate: ${jsonEncode(data)}');
//           peerConnection!.addCandidate(
//             RTCIceCandidate(
//               data['candidate'],
//               data['sdpMid'],
//               data['sdpMLineIndex'],
//             ),
//           );
//         }
//       });
//     });
//     // Listen for remote ICE candidates above
//
//     return roomId ?? "";
//   }
//
//   Future<void> joinRoom(
//     String roomId,
//     RTCVideoRenderer remoteVideo,
//   ) async {
//     DocumentReference roomRef = db.collection('rooms').doc('$roomId');
//     var roomSnapshot = await roomRef.get();
//     print('Got room ${roomSnapshot.exists}');
//
//     if (roomSnapshot.exists) {
//       print('Create PeerConnection with configuration: $configuration');
//       peerConnection = await createPeerConnection(configuration);
//
//       registerPeerConnectionListeners();
//
//       localStream?.getTracks().forEach((track) {
//         peerConnection?.addTrack(track, localStream!);
//       });
//
//       // Code for collecting ICE candidates below
//       var calleeCandidatesCollection = roomRef.collection('calleeCandidates');
//       peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
//         if (candidate == null) {
//           print('onIceCandidate: complete!');
//           return;
//         }
//         print('onIceCandidate: ${candidate.toMap()}');
//         calleeCandidatesCollection.add(candidate.toMap());
//       };
//       // Code for collecting ICE candidate above
//
//       peerConnection?.onTrack = (RTCTrackEvent event) {
//         print('Got remote track: ${event.streams[0]}');
//         event.streams[0].getTracks().forEach((track) {
//           print('Add a track to the remoteStream: $track');
//           remoteStream?.addTrack(track);
//         });
//       };
//
//       // Code for creating SDP answer below
//       var data = roomSnapshot.data() as Map<String, dynamic>;
//       print('Got offer $data');
//       var offer = data['offer'];
//       await peerConnection?.setRemoteDescription(
//         RTCSessionDescription(offer['sdp'], offer['type']),
//       );
//       var answer = await peerConnection!.createAnswer();
//       print('Created Answer $answer');
//
//       await peerConnection!.setLocalDescription(answer);
//
//       Map<String, dynamic> roomWithAnswer = {
//         'answer': {'type': answer.type, 'sdp': answer.sdp}
//       };
//
//       await roomRef.update(roomWithAnswer);
//       // Finished creating SDP answer
//
//       // Listening for remote ICE candidates below
//       roomRef.collection('callerCandidates').snapshots().listen((snapshot) {
//         snapshot.docChanges.forEach((document) {
//           var data = document.doc.data() as Map<String, dynamic>;
//           print(data);
//           print('Got new remote ICE candidate: $data');
//           peerConnection!.addCandidate(
//             RTCIceCandidate(
//               data['candidate'],
//               data['sdpMid'],
//               data['sdpMLineIndex'],
//             ),
//           );
//         });
//       });
//     }
//   }
//
//   Future<void> openUserMedia(
//     RTCVideoRenderer localVideo,
//     RTCVideoRenderer remoteVideo,
//   ) async {
//     var stream = await navigator.mediaDevices
//         .getUserMedia({'video': true, 'audio': true});
//
//     localVideo.srcObject = stream;
//     localStream = stream;
//
//     remoteVideo.srcObject = await createLocalMediaStream('key');
//   }
//
//   Future<void> onOffCamera(bool off) async {
//     if (localStream != null) {
//       if (off == true) {
//         bool enabled = localStream!.getVideoTracks()[0].enabled;
//         localStream!.getAudioTracks()[0].enabled = !enabled;
//       } else {
//         // localStream!.getVideoTracks().forEach((track) => track.stop());
//       }
//     }
//   }
//
//   Future<void> hangUp(RTCVideoRenderer localVideo) async {
//     List<MediaStreamTrack> tracks = localVideo.srcObject!.getTracks();
//     tracks.forEach((track) {
//       track.stop();
//     });
//
//     if (remoteStream != null) {
//       remoteStream!.getTracks().forEach((track) => track.stop());
//     }
//     if (peerConnection != null) peerConnection!.close();
//
//     if (roomId != null) {
//       var roomRef = db.collection('rooms').doc(roomId);
//       var call = db.collection('all_call').doc('$customerId');
//
//       var calleeCandidates = await roomRef.collection('calleeCandidates').get();
//       calleeCandidates.docs.forEach((document) => document.reference.delete());
//
//       var callerCandidates = await roomRef.collection('callerCandidates').get();
//       callerCandidates.docs.forEach((document) => document.reference.delete());
//
//       roomRef.delete();
//       call.delete();
//
//       print('===============>${customerId}');
//     }
//
//     localStream!.dispose();
//     remoteStream?.dispose();
//   }
//
//   close() async {
//     if (localStream != null) {
//       localStream!.getTracks().forEach((element) async {
//         await element.stop();
//       });
//       await localStream!.dispose();
//       localStream = null;
//     }
//   }
//
//   void switchCamera() {
//     if (localStream != null) {
//       Helper.switchCamera(localStream!.getVideoTracks()[0]);
//     }
//   }
//
//   bool muteMic() {
//     if (localStream != null) {
//       bool enabled = localStream!.getAudioTracks()[0].enabled;
//       localStream!.getAudioTracks()[0].enabled = !enabled;
//       return localStream!.getAudioTracks()[0].enabled;
//     }
//     return true;
//   }
//
//   void startAudio() async {
//     var newStream = await navigator.mediaDevices
//         .getUserMedia(_getMediaConstraints(audio: true, video: false));
//     if (localStream != null) {
//       await _removeExistingAudioTrack();
//       for (var newTrack in newStream.getAudioTracks()) {
//         await localStream!.addTrack(newTrack);
//       }
//     } else {
//       localStream = newStream;
//     }
//
//     await _addOrReplaceAudioTracks();
//
//     // setState(() {
//     //   _micOn = true;
//     // });
//   }
//
//   Future<void> _addOrReplaceAudioTracks() async {
//     for (var track in localStream!.getAudioTracks()) {
//       await _connectionAddTrack(track, localStream!);
//     }
//   }
//
//   Future<RTCRtpTransceiver?> _getSendersTransceiver(String senderId) async {
//     RTCRtpTransceiver? foundTrans;
//     var trans = await peerConnection!.getTransceivers();
//     for (var tran in trans) {
//       if (tran.sender.senderId == senderId) {
//         foundTrans = tran;
//         break;
//       }
//     }
//     return foundTrans;
//   }
//
//   Future<void> _connectionAddTrack(
//       MediaStreamTrack track, MediaStream stream) async {
//     var sender = track.kind == 'video' ? _videoSender : _audioSender;
//     if (sender != null) {
//       print('Have a Sender of kind:${track.kind}');
//       var trans = await _getSendersTransceiver(sender.senderId);
//       if (trans != null) {
//         print('Setting direction and replacing track with new track');
//         await trans.setDirection(TransceiverDirection.SendOnly);
//         await trans.sender.replaceTrack(track);
//       }
//     } else {
//       if (track.kind == 'video') {
//         _videoSender = await peerConnection!.addTrack(track, stream);
//       } else {
//         _audioSender = await peerConnection!.addTrack(track, stream);
//       }
//     }
//   }
//
//   void stopAudio() async {
//     print('sssssssss');
//     await _removeExistingAudioTrack(fromConnection: true);
//     // setState(() {
//     //   _micOn = false;
//     // });
//   }
//
//   Future<void> _removeExistingAudioTrack({bool fromConnection = false}) async {
//     var tracks = localStream!.getAudioTracks();
//     for (var i = tracks.length - 1; i >= 0; i--) {
//       var track = tracks[i];
//       if (fromConnection) {
//         await _connectionRemoveTrack(track);
//       }
//       await localStream!.removeTrack(track);
//       await track.stop();
//     }
//   }
//
//   Future<void> _connectionRemoveTrack(MediaStreamTrack track) async {
//     var sender = track.kind == 'video' ? _videoSender : _audioSender;
//     if (sender != null) {
//       print('Have a Sender of kind:${track.kind}');
//       var trans = await _getSendersTransceiver(sender.senderId);
//       if (trans != null) {
//         print('Setting direction and replacing track with null');
//         await trans.setDirection(TransceiverDirection.Inactive);
//         await trans.sender.replaceTrack(null);
//       }
//     }
//   }
//
//   Map<String, dynamic> _getMediaConstraints({audio = true, video = true}) {
//     return {
//       'audio': audio ? true : false,
//       'video': video
//           ? {
//               'mandatory': {
//                 'minWidth':
//                     '640', // Provide your own width, height and frame rate here
//                 'minHeight': '480',
//                 'minFrameRate': '30',
//               },
//               'facingMode': 'user',
//               'optional': [],
//             }
//           : false,
//     };
//   }
//
//   /// video
//
//   Future<void> startVideo(
//     RTCVideoRenderer localVideo,
//     RTCVideoRenderer remoteVideo,
//   ) async {
//     var newStream = await navigator.mediaDevices
//         .getUserMedia(_getMediaConstraints(audio: false, video: true));
//     if (localStream != null) {
//       await _removeExistingVideoTrack();
//       var tracks = newStream.getVideoTracks();
//       for (var newTrack in tracks) {
//         await localStream!.addTrack(newTrack);
//       }
//     } else {
//       localStream = newStream;
//     }
//
//     await _addOrReplaceVideoTracks();
//
//     localVideo.srcObject = localStream;
//   }
//
//   Future<void> _addOrReplaceVideoTracks() async {
//     for (var track in localStream!.getVideoTracks()) {
//       await _connectionAddTrack(track, localStream!);
//     }
//   }
//
//   Future<void> stopVideo(
//     RTCVideoRenderer localVideo,
//     RTCVideoRenderer remoteVideo,
//   ) async {
//     await _removeExistingVideoTrack(fromConnection: true);
//
//     localVideo.srcObject = null;
//     // onMute/onEnded/onUnmute are not wired up so having to force this here
//     // _remoteRenderer.srcObject = null;
//     // _cameraOn = false;
//   }
//
//   Future<void> _removeExistingVideoTrack({bool fromConnection = false}) async {
//     var tracks = localStream!.getVideoTracks();
//     for (var i = tracks.length - 1; i >= 0; i--) {
//       var track = tracks[i];
//       if (fromConnection) {
//         await _connectionRemoveTrack(track);
//       }
//       await localStream!.removeTrack(track);
//       await track.stop();
//     }
//   }
//
//   void registerPeerConnectionListeners() {
//     peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
//       print('ICE gathering state changed: $state');
//     };
//
//     peerConnection?.onConnectionState = (RTCPeerConnectionState state) {
//       if (onChangeState != null) {
//         if (state == RTCPeerConnectionState.RTCPeerConnectionStateConnected)
//           onChangeState!(CONNECTED);
//         if (state == RTCPeerConnectionState.RTCPeerConnectionStateConnecting)
//           onChangeState!(CONNECTING);
//         if (state == RTCPeerConnectionState.RTCPeerConnectionStateDisconnected)
//           onChangeState!(DISCONNECTED);
//         if (state == RTCPeerConnectionState.RTCPeerConnectionStateClosed)
//           onChangeState!(CLOSED);
//         if (state == RTCPeerConnectionState.RTCPeerConnectionStateFailed)
//           onChangeState!(FAILED);
//       }
//     };
//
//     peerConnection?.onSignalingState = (RTCSignalingState state) {
//       print('Signaling state change: $state');
//     };
//
//     peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
//       print('ICE connection state change: $state');
//     };
//
//     peerConnection?.onAddStream = (MediaStream stream) {
//       print("Add remote stream");
//       onAddRemoteStream?.call(stream);
//       remoteStream = stream;
//     };
//   }
// }
