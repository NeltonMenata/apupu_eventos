import 'package:apupu_eventos/layers/data/datasources/back4app/guest/save_guest_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/save_guest/save_guest_usecase_imp.dart';

import '../../../data/repositories_imp/guest/save_guest/save_guest_repository_imp.dart';

class AddGuestController {
  final _saveGuestUseCase = SaveGuestUseCaseImp(
    SaveGuestRepositoryImp(
      SaveGuestDataSourceBack4appImp(),
    ),
  );

  Future<GuestEntity> saveGuest(GuestEntity guest) async {
    final guestResult = await _saveGuestUseCase(guest);
    return guestResult;
  }
}
