import 'dart:convert';

import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';

class GuestDto extends GuestEntity {
  final String objectId;
  final String name;
  final String contact;

  GuestDto({
    required this.objectId,
    required this.name,
    required this.contact,
  }) : super(objectId: objectId, name: name, contact: contact);
  String toMap() {
    var map = {"objectId": objectId, "name": name, "contact": contact};
    var json = jsonEncode(map);
    return json;
  }

  factory GuestDto.fromMap(Map<String, dynamic> map) {
    return GuestDto(
        objectId: map["objectId"], name: map["name"], contact: map["contact"]);
  }
}
