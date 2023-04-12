// ignore_for_file: file_names

import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';

abstract class ISearchGuestForContactRepository {
  Future<List<GuestEntity>> call(String contact, String eventObjectId);
}
