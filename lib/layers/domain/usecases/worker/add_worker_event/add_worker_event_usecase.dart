abstract class IAddWorkerEventUseCase {
  Future<bool> call(String workerObjectId, String eventObjectId);
}
