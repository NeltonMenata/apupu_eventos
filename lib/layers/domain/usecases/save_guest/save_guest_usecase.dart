import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';

abstract class SaveGuestUseCase {
  Future<GuestEntity> call(GuestEntity entity);
}
