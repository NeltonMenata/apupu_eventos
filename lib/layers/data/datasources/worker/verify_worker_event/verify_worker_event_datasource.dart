abstract class IVerifyWorkerEventDataSource {
  Future<bool> call(String workerObjectId, String eventObjectId);
}
