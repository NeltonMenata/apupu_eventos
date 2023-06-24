import '../../../../domain/entities/report_guest/report_guest_entity.dart';
import '../../../../domain/repositories/guest/count_guest_for_worker/count_guest_for_worker_repository.dart';
import '../../../datasources/guest/count_guest_for_worker_datasource.dart';

class CountGuestForWorkerRepositoryImp
    implements ICountGuestForWorkerRepository {
  final ICountGuestForWorkerDataSource _countGuestForWorkerDataSource;
  CountGuestForWorkerRepositoryImp(this._countGuestForWorkerDataSource);
  @override
  Future<List<ReportGuestEntity>> call(
      String workerObjectId, String eventObjectId) async {
    return await _countGuestForWorkerDataSource(workerObjectId, eventObjectId);
  }
}
