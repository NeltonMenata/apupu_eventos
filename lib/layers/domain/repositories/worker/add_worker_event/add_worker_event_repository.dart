abstract class IAddWorkerEventRepository {
  Future<bool> call(String workerObjectId, String eventObjectId);
}
