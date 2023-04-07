abstract class ICountGuestForWorkerRepository {
  Future<int> call(String workerObjectId, String eventObjectId);
}
