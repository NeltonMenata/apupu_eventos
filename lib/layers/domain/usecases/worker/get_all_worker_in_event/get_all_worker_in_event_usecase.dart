import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity_minimal.dart';

abstract class IGetAllWorkerInEventUseCase {
  Future<List<WorkerEntityMinimal>> call(String eventObjectId);
}
