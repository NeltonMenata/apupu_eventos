import '../../../../domain/repositories/worker/remove_worker_event/remove_worker_event_repository.dart';
import '../../../datasources/worker/remove_worker_event/remove_worker_event_datasource.dart';

class RemoveWorkerEventRepositoryImp implements IRemoveWorkerEventRepository {
  final IRemoveWorkerEventDataSource _removeWorkerEventDataSource;
  RemoveWorkerEventRepositoryImp(this._removeWorkerEventDataSource);
  @override
  Future<bool> call(String workerObjectId, String eventObjectId) async {
    return await _removeWorkerEventDataSource(workerObjectId, eventObjectId);
  }
}
