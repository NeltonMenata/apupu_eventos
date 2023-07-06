import 'package:apupu_eventos/layers/domain/repositories/event/confirm_payment_event/confirm_payment_event_repository.dart';
import 'package:apupu_eventos/layers/domain/usecases/event/confirm_payment_event/confirm_payment_event_usecase.dart';

class ConfirmPaymentEventUseCaseImp implements IConfirmPaymentEventUseCase {
  final IConfirmPaymentEventRepository _confirmPaymentEventRepository;

  ConfirmPaymentEventUseCaseImp(this._confirmPaymentEventRepository);

  @override
  Future<bool> call(String eventObjectId) async {
    return await _confirmPaymentEventRepository(eventObjectId);
  }
}
