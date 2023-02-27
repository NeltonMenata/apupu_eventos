import 'package:apupu_eventos/layers/data/dtos/guest_dto.dart';
import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../save_guest_datasource.dart';

class SaveGuestDataSourceBack4appImp implements ISaveGuestDataSource {
  @override
  Future<GuestEntity> call(GuestEntity guestEntity) async {
    var parseObject = ParseObject("Guest");
    parseObject.set("name", guestEntity.name);
    parseObject.set("contact", guestEntity.contact);

    try {
      await parseObject.save();
      return GuestDto(
        objectId: parseObject.objectId ?? "error",
        name: parseObject.get("name") ?? "name error",
        contact: parseObject.get("contact") ?? "contact error",
        eventObjectId: parseObject.get("contact") ?? "objectId error",
        isIn: parseObject.get("isIn") ?? false,
      );
    } catch (e) {
      print(e);
      return GuestDto(
          objectId: "objectId not save",
          name: "$e",
          contact: "contact not save",
          eventObjectId: "event not save",
          isIn: false);
    }
  }
}
