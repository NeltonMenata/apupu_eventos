import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity.dart';

abstract class IWorkerLoginDataSource {
  Future<WorkerEntity> call(String username, String password);
}
