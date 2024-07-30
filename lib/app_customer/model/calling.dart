// To parse this JSON data, do
//
//     final calling = callingFromJson(jsonString);

import 'dart:convert';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';

Calling callingFromJson(String str) => Calling.fromJson(json.decode(str));

String callingToJson(Calling data) => json.encode(data.toJson());

class Calling {
  Calling({
    this.toId,
    this.fromId,
    this.avatar,
    this.name,
    this.room,
    this.type,
    this.infoCustomerTo,
    this.cameraFrom,
    this.cameraTo,
    this.requesFrom,
    this.requesTo,
    this.acceptFrom,
    this.acceptTo,
    this.state,
  });

  int? toId;
  int? fromId;
  String? avatar;
  String? name;
  String? room;
  String? type;
  InfoCustomer? infoCustomerTo;
  bool? cameraFrom;
  bool? cameraTo;
  String? requesFrom;
  String? requesTo;
  bool? acceptFrom;
  bool? acceptTo;
  String? state;

  factory Calling.fromJson(Map<String, dynamic> json) => Calling(
        toId: json["toId"] == null ? null : json["toId"],
        fromId: json["fromId"] == null ? null : json["fromId"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        name: json["name"] == null ? null : json["name"],
        room: json["room"] == null ? null : json["room"],
        type: json["type"] == null ? null : json["type"],
    cameraFrom: json["cameraFrom"] == null ? null : json["cameraFrom"],
    cameraTo: json["cameraTo"] == null ? null : json["cameraTo"],
    requesFrom: json["requesFrom"] == null ? null : json["requesFrom"],
    requesTo: json["requesTo"] == null ? null : json["requesTo"],
    acceptFrom: json["acceptFrom"] == null ? null : json["acceptFrom"],
    acceptTo: json["acceptTo"] == null ? null : json["acceptTo"],
    state: json["state"] == null ? null : json["state"],
      );

  // factory Calling.fromDoc(QueryDocumentSnapshot doc) {
  //   return Calling(
  //     toId: (doc.data() as Map)['toId'] != null
  //         ? (doc.data() as Map)['toId']
  //         : null,
  //     fromId: (doc.data() as Map)['fromId'] != null
  //         ? (doc.data() as Map)['fromId']
  //         : null,
  //     avatar: (doc.data() as Map)['avatar'] != null
  //         ? (doc.data() as Map)['avatar']
  //         : null,
  //     name: (doc.data() as Map)['name'] != null
  //         ? (doc.data() as Map)['name']
  //         : null,
  //     room: (doc.data() as Map)['room'] != null
  //         ? (doc.data() as Map)['room']
  //         : null,
  //     type: (doc.data() as Map)['type'] != null
  //         ? (doc.data() as Map)['type']
  //         : null,
  //     cameraFrom: (doc.data() as Map)['cameraFrom'] != null
  //         ? (doc.data() as Map)['cameraFrom']
  //         : null,
  //     cameraTo: (doc.data() as Map)['cameraTo'] != null
  //         ? (doc.data() as Map)['cameraTo']
  //         : null,
  //     requesFrom: (doc.data() as Map)['requesFrom'] != null
  //         ? (doc.data() as Map)['requesFrom']
  //         : null,
  //     requesTo: (doc.data() as Map)['requesTo'] != null
  //         ? (doc.data() as Map)['requesTo']
  //         : null,
  //     acceptFrom: (doc.data() as Map)['acceptFrom'] != null
  //         ? (doc.data() as Map)['acceptFrom']
  //         : null,
  //     acceptTo: (doc.data() as Map)['acceptTo'] != null
  //         ? (doc.data() as Map)['acceptTo']
  //         : null,state: (doc.data() as Map)['state'] != null
  //         ? (doc.data() as Map)['state']
  //         : null,
  //   );
  // }

  Map<String, dynamic> toJson() => {
        "toId": toId == null ? null : toId,
        "fromId": fromId == null ? null : fromId,
        "avatar": avatar == null ? null : avatar,
        "name": name == null ? null : name,
        "room": room == null ? null : room,
        "type": type == null ? null : type,
      };
}
