abstract class IRemoveWorkerEventRepository {
  Future<bool> call(String workerObjectId, String eventObjectId);
}
