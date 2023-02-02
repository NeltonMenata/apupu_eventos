import 'package:apupu_eventos/layers/data/dtos/guest_dto.dart';
import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';

import '../save_guest_datasource.dart';

class SaveGuestDataSourceBack4appImp implements SaveGuestDataSource {
  @override
  Future<GuestEntity> call(GuestEntity guestEntity) async {
    return GuestDto(
      objectId: "objectId save",
      name: "name save",
      contact: "contact save",
    );
  }
}
