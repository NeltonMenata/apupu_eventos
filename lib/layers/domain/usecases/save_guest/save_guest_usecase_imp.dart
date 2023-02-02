import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:apupu_eventos/layers/domain/repositories/save_guest/save_guest_repository.dart';
import 'save_guest_usecase.dart';

class SaveGuestUseCaseImp implements SaveGuestUseCase {
  final SaveGuestRepository _saveGuestRepository;
  SaveGuestUseCaseImp(this._saveGuestRepository);
  @override
  Future<GuestEntity> call(GuestEntity guestEntity) async {
    return _saveGuestRepository(guestEntity);
  }
}

//933 739 967