import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';

abstract class SaveGuestRepository {
  Future<GuestEntity> call(GuestEntity guestEntity);
}
