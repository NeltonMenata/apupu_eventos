// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:convert';

import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';

class GuestDto extends GuestEntity {
  final String objectId;
  final String name;
  final String contact;
  final bool isIn;
  final String eventObjectId;
  final String doormanObjectId;

  GuestDto(
      {required this.objectId,
      required this.name,
      required this.contact,
      required this.isIn,
      required this.eventObjectId,
      required this.doormanObjectId})
      : super(
            objectId: objectId,
            name: name,
            contact: contact,
            eventObjectId: eventObjectId,
            doormanObjectId: doormanObjectId,
            isIn: isIn);
  String toMap() {
    var map = {
      "objectId": objectId,
      "name": name,
      "contact": contact,
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
        eventObjectId: map["eventObjectId"],
        doormanObjectId: map["doormanObjectId"]);
  }

  @override
  String toString() {
    super.toString();
    return "objectId: $objectId, name: $name, contact: $contact, isIn: $isIn, eventObjectId: $eventObjectId";
  }
}
