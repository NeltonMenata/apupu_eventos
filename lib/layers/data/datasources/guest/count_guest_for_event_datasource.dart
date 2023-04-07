abstract class ICountGuestForEventDataSource {
  Future<int> call(String eventObjectId);
}
