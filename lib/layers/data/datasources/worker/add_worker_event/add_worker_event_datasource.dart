abstract class IAddWorkerEventDataSource {
  Future<bool> call(String workerObjectId, String eventObjectId);
}
