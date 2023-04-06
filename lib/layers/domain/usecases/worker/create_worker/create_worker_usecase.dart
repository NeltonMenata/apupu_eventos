import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity.dart';

abstract class ICreateWorkerUseCase {
  Future<WorkerEntity> call(WorkerEntity worker);
}
