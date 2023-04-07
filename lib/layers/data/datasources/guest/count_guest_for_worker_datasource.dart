abstract class ICountGuestForWorkerDataSource {
  Future<int> call(String workerObjectId, String eventObjectId);
}
