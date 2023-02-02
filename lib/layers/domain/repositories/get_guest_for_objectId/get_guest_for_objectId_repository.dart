import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';

abstract class GetGuestForObjectIdRepository {
  Future<GuestEntity> call(String objectId);
}
