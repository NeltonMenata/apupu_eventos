import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity.dart';

import '../../../repositories/worker/create_worker/create_worker_repository.dart';
import 'create_worker_usecase.dart';

class CreateWorkerUseCaseImp implements ICreateWorkerUseCase {
  final ICreateWorkerRepository _createWorkerRepository;
  CreateWorkerUseCaseImp(this._createWorkerRepository);
  @override
  Future<WorkerEntity> call(WorkerEntity worker) async {
    return await _createWorkerRepository(worker);
  }
}
