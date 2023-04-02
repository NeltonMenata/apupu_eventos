abstract class IDoneInOrOutGuestDataSource {
  Future<bool> call(String objectId, bool inOrOut);
}
