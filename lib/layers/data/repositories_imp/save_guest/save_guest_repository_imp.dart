import 'package:apupu_eventos/layers/data/datasources/save_guest_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import '../../../domain/repositories/save_guest/save_guest_repository.dart';

class SaveGuestRepositoryImp implements ISaveGuestRepository {
  final ISaveGuestDataSource _saveGuestDataSource;
  SaveGuestRepositoryImp(this._saveGuestDataSource);

  @override
  Future<GuestEntity> call(GuestEntity guestEntity) {
    return _saveGuestDataSource(guestEntity);
  }
}
