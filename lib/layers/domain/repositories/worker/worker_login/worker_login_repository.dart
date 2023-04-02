import '../../../entities/worker/worker_entity.dart';

abstract class IWorkerLoginRepository {
  Future<WorkerEntity> call(String username, String password);
}
