import '../../../domain/entities/guest/guest_entity.dart';

class SearchGuestController {
  final List<GuestEntity> listGuest = [];
  SearchGuestController() {
    for (var i = 0; i < 30; i++) {
      listGuest.add(GuestEntity(
          eventObjectId: "",
          name: "Nelton Menata",
          contact: "94135714$i",
          objectId: "",
          isIn: false));
    }
  }
}
