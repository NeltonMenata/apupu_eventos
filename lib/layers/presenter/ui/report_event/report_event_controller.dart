import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity_minimal.dart';
import '../../../domain/usecases/guest/count_guest_for_event/count_guest_for_event_usecase.dart';
import '../../../domain/usecases/guest/count_guest_for_worker/count_guest_for_worker_usecase.dart';
import '../../../domain/usecases/worker/get_all_worker_in_event/get_all_worker_in_event_usecase.dart';

class ReportEventController {
  final IGetAllWorkerInEventUseCase _getAllWorkerInEventUseCase;
  final ICountGuestForEventUseCase _countGuestForEventUseCase;
  final ICountGuestForWorkerUseCase _countGuestForWorkerUseCase;

  ReportEventController(this._getAllWorkerInEventUseCase,
      this._countGuestForEventUseCase, this._countGuestForWorkerUseCase);

  Future<List<WorkerEntityMinimal>> getAllWorkerInEvent(
      String eventObjectId) async {
    return await _getAllWorkerInEventUseCase(eventObjectId);
  }

  Future<int> countGuestEvent(String eventObjectId) async {
    return await _countGuestForEventUseCase(eventObjectId);
  }

  Future<int> countGuestWorker(
      String workerObjectId, String eventObjectId) async {
    return await _countGuestForWorkerUseCase(workerObjectId, eventObjectId);
  }
}
