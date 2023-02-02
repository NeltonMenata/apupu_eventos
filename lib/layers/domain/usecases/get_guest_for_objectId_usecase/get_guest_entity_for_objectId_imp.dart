import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:apupu_eventos/layers/domain/repositories/get_guest_for_objectId/get_guest_for_objectId_repository.dart';
import 'package:apupu_eventos/layers/domain/usecases/get_guest_for_objectId_usecase/get_guest_entity_for_objectId.dart';

class GetGuestForObjectIdUseCaseImp implements GetGuestForObjectIdUseCase {
  final GetGuestForObjectIdRepository _getGuestForObjectIdRepository;
  GetGuestForObjectIdUseCaseImp(this._getGuestForObjectIdRepository);

  @override
  Future<GuestEntity> call(String objectId) async {
    return await _getGuestForObjectIdRepository(objectId);
  }
}
