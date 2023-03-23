import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../save_guest_datasource.dart';

class SaveGuestDataSourceBack4appImp implements ISaveGuestDataSource {
  @override
  Future<GuestEntity> call(GuestEntity guestEntity) async {
    final saveGuest = ParseCloudFunction("saveGuest");

    try {
      final result = await saveGuest.execute(parameters: {
        "name": guestEntity.name,
        "contact": guestEntity.contact,
        "eventObjectId": guestEntity.eventObjectId,
        "doormanObjectId": guestEntity.doormanObjectId
      });

      if (result.statusCode == 200) {
        return GuestEntity(
          objectId: result.result["objectId"],
          name: result.result["name"],
          doormanObjectId: result.result["doormanObjectId"],
          eventObjectId: result.result["eventObjectId"],
          contact: result.result["contact"],
          isIn: result.result["isIn"],
        );

        // EventDto.fromMap(saveEvent.results![0]);
      }
    } catch (e) {
      print(e);
      return GuestEntity(
        objectId: "objectId",
        name: "User not save",
        doormanObjectId: "doormanId",
        eventObjectId: "eventId",
        contact: "Contact",
        isIn: false,
      );
    }

    return GuestEntity(
        objectId: "objectId",
        name: "name",
        contact: "contact",
        doormanObjectId: "doorman",
        eventObjectId: "eventObjectId");
  }
}
