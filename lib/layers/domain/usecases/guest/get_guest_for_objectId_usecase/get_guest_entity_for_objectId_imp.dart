// ignore: file_names
import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:apupu_eventos/layers/domain/repositories/get_guest_for_objectId/get_guest_for_objectId_repository.dart';

import 'get_guest_entity_for_objectId.dart';

class GetGuestForObjectIdUseCaseImp implements IGetGuestForObjectIdUseCase {
  final IGetGuestForObjectIdRepository _getGuestForObjectIdRepository;
  GetGuestForObjectIdUseCaseImp(this._getGuestForObjectIdRepository);

  @override
  Future<GuestEntity> call(String objectId, String eventObjectId) async {
    return await _getGuestForObjectIdRepository(objectId, eventObjectId);
  }
}
