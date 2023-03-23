abstract class IDoneInOrOutGuestUseCase {
  Future<bool> call(String objectId, bool inOrOut);
}
