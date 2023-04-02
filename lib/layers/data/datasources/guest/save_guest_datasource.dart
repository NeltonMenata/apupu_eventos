import '../../../domain/entities/guest/guest_entity.dart';

abstract class ISaveGuestDataSource {
  Future<GuestEntity> call(GuestEntity guestEntity);
}
