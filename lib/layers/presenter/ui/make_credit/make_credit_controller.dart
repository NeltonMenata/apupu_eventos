import 'package:apupu_eventos/layers/domain/entities/credit/credit_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/credit/make_credit/make_credit_usecase.dart';

import '../../../domain/entities/guest/guest_entity.dart';
import '../../../domain/usecases/guest/get_guest_for_objectId_usecase/get_guest_entity_for_objectId.dart';

class MakeCreditController {
  final IGetGuestForObjectIdUseCase _getGuestForObjectIdUseCase;
  final IMakeCreditUseCase _makeCreditUseCase;
  MakeCreditController(
      this._getGuestForObjectIdUseCase, this._makeCreditUseCase);

  Future<GuestEntity> getGuest(String objectId, String eventObjectId) async {
    return await _getGuestForObjectIdUseCase(objectId, eventObjectId);
  }

  Future<CreditEntity> makeCredit(CreditEntity credit) async {
    return await _makeCreditUseCase(credit);
  }
}
