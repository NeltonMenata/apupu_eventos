abstract class ICountGuestForEventRepository {
  Future<int> call(String eventObjectId);
}
