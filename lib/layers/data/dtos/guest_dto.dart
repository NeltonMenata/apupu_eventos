// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:convert';

import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';

class GuestDto extends GuestEntity {
  final String objectId;
  final String name;
  final String contact;
  final int? credit;
  final bool isVip;
  final bool isIn;
  final String eventObjectId;
  final String workerObjectId;

  GuestDto(
      {required this.objectId,
      required this.name,
      required this.contact,
      this.credit,
      required this.isIn,
      required this.isVip,
      required this.eventObjectId,
      required this.workerObjectId})
      : super(
            objectId: objectId,
            name: name,
            contact: contact,
            credit: credit,
            isVip: isVip,
            eventObjectId: eventObjectId,
            workerObjectId: workerObjectId,
            isIn: isIn);
  String toMap() {
    var map = {
      "objectId": objectId,
      "name": name,
      "contact": contact,
      "isVip": isVip,
      "eventObjectId": eventObjectId,
      "isIn": isIn
    };
    var json = jsonEncode(map);
    return json;
  }

  factory GuestDto.fromMap(Map<String, dynamic> map) {
    return GuestDto(
        objectId: map["objectId"],
        name: map["name"],
        contact: map["contact"],
        isIn: map["isIn"],
        isVip: map["isVip"],
        eventObjectId: map["eventObjectId"],
        workerObjectId: map["workerObjectId"]);
  }

  @override
  String toString() {
    super.toString();
    return "objectId: $objectId, name: $name, contact: $contact, isIn: $isIn, eventObjectId: $eventObjectId";
  }
}
