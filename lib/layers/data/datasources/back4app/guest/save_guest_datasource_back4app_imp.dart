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
        "eventObjectId": guestEntity.eventObjectId,
        "workerObjectId": guestEntity.workerObjectId
      });

      if (result.statusCode == 200) {
        return GuestEntity(
          objectId: result.result["objectId"],
          name: result.result["name"],
          workerObjectId: result.result["workerObjectId"],
          eventObjectId: result.result["eventObjectId"].toString(),
          contact: result.result["contact"],
          isIn: result.result["isIn"],
        );

        // EventDto.fromMap(saveEvent.results![0]);
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

    return GuestEntity(
        objectId: "objectId",
        name: "name",
        contact: "contact",
        workerObjectId: "worker",
        eventObjectId: "eventObjectId");
  }
}
