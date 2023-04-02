import 'package:apupu_eventos/layers/data/datasources/guest/get_guest_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/mock/database_mock.dart';
import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';

class GetGuestDataSourceMockImp implements IGetGuestDataSource {
  @override
  Future<GuestEntity> call(String objectId, String eventObjectId) async {
    final element = int.tryParse(objectId) ?? 0;
    final length = DataBaseMock.listGuestEntity.length;
    if (element >= length) {
      return GuestEntity(
          objectId: "objectId",
          name: "name",
          contact: "contact",
          workerObjectId: "workerId",
          eventObjectId: "eventObjectId");
    }

    final result = DataBaseMock.listGuestEntity.elementAt(element);
    return result;
  }
}
