abstract class IDoneInOrOutGuestRepository {
  Future<bool> call(String objectId, bool inOrOut);
}
