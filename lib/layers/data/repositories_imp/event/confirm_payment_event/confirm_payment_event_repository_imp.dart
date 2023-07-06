import 'package:apupu_eventos/layers/data/datasources/event/confirm_payment_event_datasource.dart';
import 'package:apupu_eventos/layers/domain/repositories/event/confirm_payment_event/confirm_payment_event_repository.dart';

class ConfirmPaymentEventRepositoryImp
    implements IConfirmPaymentEventRepository {
  final IConfirmPaymentEventDataSource _confirmPaymentEventDataSource;

  ConfirmPaymentEventRepositoryImp(this._confirmPaymentEventDataSource);
  @override
  Future<bool> call(String eventObjectId) async {
    return await _confirmPaymentEventDataSource(eventObjectId);
  }
}
