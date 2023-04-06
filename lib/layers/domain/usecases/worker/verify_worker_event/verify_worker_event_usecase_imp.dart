import 'package:apupu_eventos/layers/domain/repositories/worker/verify_worker_event/verify_worker_event_repository.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/verify_worker_event/verify_worker_event_usecase.dart';

class VerifyWorkerEventUseCaseImp implements IVerifyWorkerEventUseCase {
  final IVerifyWorkerEventRepository _verifyWorkerEventRepository;
  VerifyWorkerEventUseCaseImp(this._verifyWorkerEventRepository);
  @override
  Future<bool> call(String workerObjectId, String eventObjectId) async {
    return await _verifyWorkerEventRepository(workerObjectId, eventObjectId);
  }
}
