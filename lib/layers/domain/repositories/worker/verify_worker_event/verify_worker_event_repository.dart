abstract class IVerifyWorkerEventRepository {
  Future<bool> call(String workerObjectId, String eventObjectId);
}
