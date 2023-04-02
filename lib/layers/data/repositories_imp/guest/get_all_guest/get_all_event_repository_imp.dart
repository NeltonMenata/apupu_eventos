import '../../../../domain/entities/guest/guest_entity.dart';
import '../../../../domain/repositories/guest/get_all_guest_repository/get_all_event_repository.dart';
import '../../../datasources/guest/get_all_guest_datasource.dart';

class GetAllGuestRepositoryImp implements IGetAllGuestRepository {
  final IGetAllGuestDataSource _getAllGuestDataSource;

  GetAllGuestRepositoryImp(this._getAllGuestDataSource);

  @override
  Future<List<GuestEntity>> call() async {
    return _getAllGuestDataSource();
  }
}
