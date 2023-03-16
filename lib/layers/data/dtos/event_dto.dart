import 'dart:convert';
import '../../domain/entities/event/event_entity.dart';

class EventDto extends EventEntity {
  final String objectId;
  final String name;
  final String organization;
  final DateTime dateOfRealization;
  final double price;
  final String imgCatalog;
  EventDto(
      {required this.objectId,
      required this.name,
      required this.dateOfRealization,
      required this.organization,
      required this.imgCatalog,
      required this.price})
      : super(
            objectId: objectId,
            name: name,
            imgCatalog: imgCatalog,
            organization: organization,
            price: price,
            dateOfRealization: dateOfRealization);
  String toMap() {
    var map = {
      "objectId": objectId,
      "name": name,
      "imgCatalog": imgCatalog,
      "organization": organization,
      "dateOfRealization": dateOfRealization,
      "price": price
    };
    var json = jsonEncode(map);
    return json;
  }

  factory EventDto.fromMap(Map<String, dynamic> e) {
    return EventDto(
        dateOfRealization: DateTime.parse(e["dateOfRealization"]["iso"]),
        imgCatalog: e["imgCatalog"].toString(),
        name: e["name"].toString(),
        objectId: e["objectId"].toString(),
        organization: e["organization"].toString(),
        price: double.parse(e["price"].toString()));
  }

  @override
  String toString() {
    super.toString();
    return "objectId: $objectId, name: $name, organization: $organization, dateOfRealization: $dateOfRealization, price: $price";
  }
}
