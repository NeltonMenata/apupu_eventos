abstract class IConfirmPaymentEventUseCase {
  Future<bool> call(String eventObjectId);
}
