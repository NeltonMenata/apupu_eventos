import '../../../repositories/worker/add_worker_event/add_worker_event_repository.dart';
import 'add_worker_event_usecase.dart';

class AddWorkerEventUseCaseImp implements IAddWorkerEventUseCase {
  final IAddWorkerEventRepository _addWorkerEventRepository;
  AddWorkerEventUseCaseImp(this._addWorkerEventRepository);
  @override
  Future<bool> call(String workerObjectId, String eventObjectId) async {
    return await _addWorkerEventRepository(workerObjectId, eventObjectId);
  }
}
