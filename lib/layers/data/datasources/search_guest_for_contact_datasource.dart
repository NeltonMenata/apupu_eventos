import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';

abstract class ISearchGuestForContactDataSource {
  Future<List<GuestEntity>> call(String contact, String eventObjectId);
}
