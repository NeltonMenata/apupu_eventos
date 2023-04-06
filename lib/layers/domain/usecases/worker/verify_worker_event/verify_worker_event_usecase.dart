abstract class IVerifyWorkerEventUseCase {
  Future<bool> call(String workerObjectId, String eventObjectId);
}
