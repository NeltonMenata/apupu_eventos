import 'package:apupu_eventos/layers/data/datasources/get_guest_datasource.dart';
import 'package:apupu_eventos/layers/data/dtos/guest_dto.dart';
import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';

class GetGuestDataSourceBack4appImp implements GetGuestDataSource {
  @override
  Future<GuestEntity> call(String objectId) async {
    return GuestDto(
      objectId: "objectId get",
      name: "name get",
      contact: "contact get",
    );
  }
}
