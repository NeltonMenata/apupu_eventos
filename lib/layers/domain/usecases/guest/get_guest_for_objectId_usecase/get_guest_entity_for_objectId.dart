// ignore: file_names
import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';

abstract class IGetGuestForObjectIdUseCase {
  Future<GuestEntity> call(String objectId, String eventObjectId);
}
