import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';

abstract class IGetGuestForObjectIdRepository {
  Future<GuestEntity> call(String objectId, String eventObjectId);
}
