import 'package:apupu_eventos/layers/domain/usecases/worker/remove_worker_event/remove_worker_event_usecase.dart';

import '../../../repositories/worker/remove_worker_event/remove_worker_event_repository.dart';

class RemoveWorkerEventUseCaseImp implements IRemoveWorkerEventUseCase {
  final IRemoveWorkerEventRepository _removeWorkerEventRepository;
  RemoveWorkerEventUseCaseImp(this._removeWorkerEventRepository);
  @override
  Future<bool> call(String workerObjectId, String eventObjectId) async {
    return await _removeWorkerEventRepository(workerObjectId, eventObjectId);
  }
}
