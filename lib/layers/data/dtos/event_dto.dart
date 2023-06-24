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
  final int? bonusCredit;
  final String? error;
  EventDto(
      {required this.objectId,
      required this.name,
      required this.dateOfRealization,
      required this.organization,
      this.managerObjectId,
      required this.imgCartaz,
      this.priceVip,
      required this.price,
      this.bonusCredit,
      this.error})
      : super(
            objectId: objectId,
            name: name,
            imgCartaz: imgCartaz,
            organization: organization,
            managerObjectId: managerObjectId,
            price: price,
            priceVip: priceVip,
            dateOfRealization: dateOfRealization,
            bonusCredit: bonusCredit,
            error: error);
  String toMap() {
    var map = {
      "objectId": objectId,
      "name": name,
      "imgCartaz": imgCartaz,
      "organization": organization,
      "dateOfRealization": dateOfRealization,
      "managerObjectId": managerObjectId,
      "price": price,
      "priceVip": priceVip,
      "bonusredit": bonusCredit
    };
    var json = jsonEncode(map);
    return json;
  }

  factory EventDto.fromMap(Map<String, dynamic> e) {
    return EventDto(
        objectId: "objectId",
        name: "name",
        dateOfRealization: DateTime.now(),
        organization: "organization",
        imgCartaz: "imgCatalog",
        price: 0);
    // dateOfRealization: DateTime.parse(e["dateOfRealization"]["iso"]),
    // imgCartaz: e["imgCartaz"],
    // name: e["name"].toString(),
    // objectId: e["objectId"].toString(),
    // managerObjectId: e["managerObjectId"],
    // organization: e["organization"].toString(),
    // priceVip: e["priceVip"],
    // price: e["price"],
    // bonusCredit: e["bonusCredit"]);
  }

  @override
  String toString() {
    super.toString();
    return "objectId: $objectId, name: $name, organization: $organization, dateOfRealization: $dateOfRealization, price: $price";
  }
}
