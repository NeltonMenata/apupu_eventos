abstract class IRemoveWorkerEventUseCase {
  Future<bool> call(String workerObjectId, String eventObjectId);
}
