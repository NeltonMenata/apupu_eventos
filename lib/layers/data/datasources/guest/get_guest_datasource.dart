import '../../../domain/entities/guest/guest_entity.dart';

abstract class IGetGuestDataSource {
  Future<GuestEntity> call(String objectId, String eventObjectId);
}
