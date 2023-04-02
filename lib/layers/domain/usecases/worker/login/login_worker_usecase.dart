import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity.dart';

abstract class ILoginWorkerUseCase {
  Future<WorkerEntity> call(String username, String password);
}
