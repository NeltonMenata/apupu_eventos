import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity.dart';

abstract class IGetAllWorkerUseCase {
  Future<List<WorkerEntity>> call();
}
