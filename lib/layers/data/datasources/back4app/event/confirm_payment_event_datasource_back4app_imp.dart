import 'package:apupu_eventos/layers/data/datasources/event/confirm_payment_event_datasource.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class ConfirmPaymentEventDataSourceBack4appImp
    implements IConfirmPaymentEventDataSource {
  @override
  Future<bool> call(String eventObjectId) async {
    final paymentEvent = ParseCloudFunction("confirmPaymentEvent");

    try {
      final confirmPayment = await paymentEvent
          .execute(parameters: {"eventObjectId": eventObjectId});
      return confirmPayment.result["payment"] as bool;
    } catch (e) {
      return false;
    }
  }
}
