import 'package:apupu_eventos/layers/data/datasources/back4app/save_guest_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/save_guest_datasource.dart';
import 'package:apupu_eventos/layers/data/dtos/guest_dto.dart';
import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';

import '../../../domain/repositories/save_guest/save_guest_repository.dart';

class SaveGuestRepositoryImp implements SaveGuestRepository {
  final SaveGuestDataSource _saveGuestDataSource;
  SaveGuestRepositoryImp(this._saveGuestDataSource);

  @override
  Future<GuestEntity> call(GuestEntity guestEntity) {
    return _saveGuestDataSource(guestEntity);
  }
}
