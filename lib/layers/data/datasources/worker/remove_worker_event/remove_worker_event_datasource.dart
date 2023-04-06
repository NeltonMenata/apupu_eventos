abstract class IRemoveWorkerEventDataSource {
  Future<bool> call(String workerObjectId, String eventObjectId);
}
