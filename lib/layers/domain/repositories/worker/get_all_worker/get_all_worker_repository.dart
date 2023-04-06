import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity.dart';

abstract class IGetAllWorkerRepository {
  Future<List<WorkerEntity>> call();
}
