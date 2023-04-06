import '../../../../domain/repositories/worker/add_worker_event/add_worker_event_repository.dart';
import '../../../datasources/worker/add_worker_event/add_worker_event_datasource.dart';

class AddWorkerEventRepositoryImp implements IAddWorkerEventRepository {
  final IAddWorkerEventDataSource _addWorkerEventDataSource;
  AddWorkerEventRepositoryImp(this._addWorkerEventDataSource);
  @override
  Future<bool> call(String workerObjectId, String eventObjectId) async {
    return await _addWorkerEventDataSource(workerObjectId, eventObjectId);
  }
}
