import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity.dart';

abstract class IGetAllWorkerDataSource {
  Future<List<WorkerEntity>> call([String? managerObjectId]);
}
