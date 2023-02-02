import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/get_guest_for_objectId_usecase/get_guest_entity_for_objectId.dart';
import 'package:apupu_eventos/layers/domain/usecases/save_guest/save_guest_usecase.dart';

class HomeController {
  final SaveGuestUseCase _saveGuest;
  final GetGuestForObjectIdUseCase _getGuestForObjectIdUseCase;
  HomeController(this._saveGuest, this._getGuestForObjectIdUseCase);

  Future<GuestEntity> saveGuest(GuestEntity _guestEntity) async {
    return await _saveGuest(_guestEntity);
  }

  Future<GuestEntity> getGuest(String objectId) async {
    return _getGuestForObjectIdUseCase(objectId);
  }
}
