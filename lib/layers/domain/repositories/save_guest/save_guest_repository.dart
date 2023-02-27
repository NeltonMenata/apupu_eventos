import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';

abstract class ISaveGuestRepository {
  Future<GuestEntity> call(GuestEntity guestEntity);
}
