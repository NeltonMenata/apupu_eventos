import '../../../data/datasources/back4app/guest/done_in_or_out_guest_datasource_back4app_imp.dart';
import '../../../data/repositories_imp/guest/done_in_or_out_guest/done_in_or_out_guest_repository_imp.dart';
import '../../../domain/usecases/guest/done_in_or_out_guest/done_in_or_out_guest.dart';
import '../../../domain/usecases/guest/done_in_or_out_guest/done_in_or_out_guest_imp.dart';

mixin DoneInOrOutGuestMixin {
  final IDoneInOrOutGuestUseCase _doneInOrOutGuestUseCase =
      DoneInOrOutGuestUseCaseImp(
    DoneInOrOutGuestRepositoryImp(
      DoneInOrOutGuestDatasourceBack4appImp(),
    ),
  );
  Future<bool> doneInOrOutGuest(String objectId, bool inOrOut) async {
    return await _doneInOrOutGuestUseCase(objectId, inOrOut);
  }
}
