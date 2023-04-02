import '../../../../domain/repositories/guest/done_in_or_out_guest_repository/done_in_or_out_guest_repository.dart';
import '../../../datasources/guest/done_in_or_out_guest_datasource.dart';

class DoneInOrOutGuestRepositoryImp implements IDoneInOrOutGuestRepository {
  final IDoneInOrOutGuestDataSource _doneInOrOutGuestDataSource;

  DoneInOrOutGuestRepositoryImp(this._doneInOrOutGuestDataSource);

  @override
  Future<bool> call(String objectId, bool inOrOut) {
    return _doneInOrOutGuestDataSource(objectId, inOrOut);
  }
}
