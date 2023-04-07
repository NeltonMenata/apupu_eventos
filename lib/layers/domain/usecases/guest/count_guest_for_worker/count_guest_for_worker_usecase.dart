abstract class ICountGuestForWorkerUseCase {
  Future<int> call(String workerObjectId, String eventObjectId);
}
