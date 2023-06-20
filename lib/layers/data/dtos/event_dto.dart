// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:convert';
import '../../domain/entities/event/event_entity.dart';

class EventDto extends EventEntity {
  final String objectId;
  final String name;
  final String organization;
  final DateTime dateOfRealization;
  final String? managerObjectId;
  final int price;
  final int? priceVip;
  final String? imgCartaz;
  EventDto(
      {required this.objectId,
      required this.name,
      required this.dateOfRealization,
      required this.organization,
      this.managerObjectId,
      required this.imgCartaz,
      this.priceVip,
      required this.price})
      : super(
            objectId: objectId,
            name: name,
            imgCartaz: imgCartaz,
            organization: organization,
            managerObjectId: managerObjectId,
            price: price,
            priceVip: priceVip,
            dateOfRealization: dateOfRealization);
  String toMap() {
    var map = {
      "objectId": objectId,
      "name": name,
      "imgCartaz": imgCartaz,
      "organization": organization,
      "dateOfRealization": dateOfRealization,
      "managerObjectId": managerObjectId,
      "price": price,
      "priceVip": priceVip
    };
    var json = jsonEncode(map);
    return json;
  }

  factory EventDto.fromMap(Map<String, dynamic> e) {
    return EventDto(
        dateOfRealization: DateTime.parse(e["dateOfRealization"]["iso"]),
        imgCartaz: e["imgCartaz"],
        name: e["name"].toString(),
        objectId: e["objectId"].toString(),
        managerObjectId: e["managerObjectId"],
        organization: e["organization"].toString(),
        priceVip: int.tryParse(e["priceVip"].toString()),
        price: int.parse(e["price"].toString()));
  }

  @override
  String toString() {
    super.toString();
    return "objectId: $objectId, name: $name, organization: $organization, dateOfRealization: $dateOfRealization, price: $price";
  }
}
