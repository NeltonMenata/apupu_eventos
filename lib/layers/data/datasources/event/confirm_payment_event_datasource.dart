abstract class IConfirmPaymentEventDataSource {
  Future<bool> call(String eventObjectId);
}
