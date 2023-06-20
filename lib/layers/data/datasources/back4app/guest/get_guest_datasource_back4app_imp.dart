import 'package:apupu_eventos/layers/data/datasources/guest/get_guest_datasource.dart';
import 'package:apupu_eventos/layers/data/dtos/guest_dto.dart';
import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class GetGuestDataSourceBack4appImp implements IGetGuestDataSource {
  @override
  Future<GuestEntity> call(String objectId, String eventObjectId) async {
    try {
      final getOneGuest = ParseCloudFunction("getOneGuest");

      final result = await getOneGuest.execute(
          parameters: {"objectId": objectId, "eventObjectId": eventObjectId});

      return GuestDto(
        objectId: result.result["objectId"],
        name: result.result["name"],
        workerObjectId: result.result["workerObjectId"],
        eventObjectId: result.result["eventObjectId"],
        contact: result.result["contact"],
        isVip: result.result["isVip"],
        credit: result.result["credit"],
        isIn: result.result["isIn"],
      );
    } catch (e) {
      return GuestDto(
        objectId: "objectId get",
        name: "not found",
        contact: "contact",
        isVip: false,
        eventObjectId: 'eventObjectId get',
        workerObjectId: "worker Object Id",
        isIn: false,
      );
    }
  }
}
