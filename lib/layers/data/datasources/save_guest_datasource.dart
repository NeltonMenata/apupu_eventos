import 'package:apupu_eventos/layers/data/dtos/guest_dto.dart';

import '../../domain/entities/guest/guest_entity.dart';

abstract class SaveGuestDataSource {
  Future<GuestEntity> call(GuestEntity guestEntity);
}
