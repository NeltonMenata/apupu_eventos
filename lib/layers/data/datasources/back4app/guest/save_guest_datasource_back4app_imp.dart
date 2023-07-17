import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../guest/save_guest_datasource.dart';

class SaveGuestDataSourceBack4appImp implements ISaveGuestDataSource {
  @override
  Future<GuestEntity> call(GuestEntity guestEntity) async {
    final saveGuest = ParseCloudFunction("saveGuest");

    try {
      final result = await saveGuest.execute(parameters: {
        "name": guestEntity.name,
        "contact": guestEntity.contact,
        "credit": guestEntity.credit,
        "eventObjectId": guestEntity.eventObjectId,
        "isVip": guestEntity.isVip,
        "workerObjectId": guestEntity.workerObjectId
      });

      if (result.statusCode == 200) {
        if (result.result["error"] != null) {
          return GuestEntity(
              objectId: "objectId",
              name: "name",
              contact: "contact",
              workerObjectId: "workerObjectId",
              eventObjectId: "eventObjectId",
              error: result.result["error"]);
        }
        return GuestEntity(
            objectId: result.result["objectId"],
            name: result.result["name"],
            workerObjectId: result.result["workerObjectId"],
            eventObjectId: result.result["eventObjectId"].toString(),
            contact: result.result["contact"],
            credit: result.result["credit"],
            isIn: result.result["isIn"],
            isVip: result.result["isVip"]);

        // EventDto.fromMap(saveEvent.results![0]);
      } else {
        return GuestEntity(
            objectId: "objectId",
            name: "name",
            contact: "contact",
            workerObjectId: "workerObjectId",
            eventObjectId: "eventObjectId",
            error: result.error?.message);
      }
    } catch (e) {
      return GuestEntity(
        objectId: "objectId",
        name: "User not save",
        workerObjectId: "workerId",
        eventObjectId: "eventId",
        contact: "contact",
        isIn: false,
      );
    }
  }
}
