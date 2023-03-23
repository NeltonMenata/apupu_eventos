import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:apupu_eventos/layers/domain/repositories/get_guest_for_objectId/get_guest_for_objectId_repository.dart';

import '../../datasources/get_guest_datasource.dart';

class GetGuestForObjectIdRepositoryImp
    implements IGetGuestForObjectIdRepository {
  final IGetGuestDataSource _getGuestDataSource;

  GetGuestForObjectIdRepositoryImp(this._getGuestDataSource);

  @override
  Future<GuestEntity> call(String objectId, String eventObjectId) {
    return _getGuestDataSource(objectId, eventObjectId);
  }
}
