import '../../../repositories/guest/done_in_or_out_guest_repository/done_in_or_out_guest_repository.dart';
import 'done_in_or_out_guest.dart';

class DoneInOrOutGuestUseCaseImp implements IDoneInOrOutGuestUseCase {
  final IDoneInOrOutGuestRepository _doneInOrOutGuestRepository;
  DoneInOrOutGuestUseCaseImp(this._doneInOrOutGuestRepository);

  @override
  Future<bool> call(String objectId, bool inOrOut) async {
    return await _doneInOrOutGuestRepository(objectId, inOrOut);
  }
}
