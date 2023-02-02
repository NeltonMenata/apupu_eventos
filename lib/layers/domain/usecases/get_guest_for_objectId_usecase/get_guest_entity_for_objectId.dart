import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';

abstract class GetGuestForObjectIdUseCase {
  Future<GuestEntity> call(String objectId);
}
