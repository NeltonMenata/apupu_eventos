import '../../domain/entities/guest/guest_entity.dart';

abstract class GetGuestDataSource {
  Future<GuestEntity> call(String objectId);
}
