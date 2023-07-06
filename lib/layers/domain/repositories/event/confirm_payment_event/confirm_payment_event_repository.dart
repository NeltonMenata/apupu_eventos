abstract class IConfirmPaymentEventRepository {
  Future<bool> call(String eventObjectId);
}
