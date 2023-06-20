import 'package:apupu_eventos/layers/domain/entities/report_credit/report_credit_entity.dart';
import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity_minimal.dart';
import 'package:apupu_eventos/layers/domain/usecases/credit/get_all_credit_for_event/get_all_credit_for_event_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/sale/get_all_sale_for_event/get_all_sale_for_event_usecase.dart';
import '../../../domain/entities/report_sale/report_sale_entity.dart';
import '../../../domain/usecases/guest/count_guest_for_event/count_guest_for_event_usecase.dart';
import '../../../domain/usecases/guest/count_guest_for_worker/count_guest_for_worker_usecase.dart';
import '../../../domain/usecases/worker/get_all_worker_in_event/get_all_worker_in_event_usecase.dart';

class ReportEventController {
  final IGetAllWorkerInEventUseCase _getAllWorkerInEventUseCase;
  final ICountGuestForEventUseCase _countGuestForEventUseCase;
  final ICountGuestForWorkerUseCase _countGuestForWorkerUseCase;
  final IGetAllSaleForEventUseCase _getAllSaleForEventUseCase;
  final IGetAllCreditForEventUseCase _getAllCreditForEventUseCase;

  ReportEventController(
      this._getAllWorkerInEventUseCase,
      this._countGuestForEventUseCase,
      this._countGuestForWorkerUseCase,
      this._getAllCreditForEventUseCase,
      this._getAllSaleForEventUseCase);

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

  Future<List<ReportCreditEntity>> getAllCreditForEvent(
      String eventObjectId) async {
    return await _getAllCreditForEventUseCase(eventObjectId);
  }

  Future<List<ReportSaleEntity>> getAllSaleForEvent(
      String eventObjectId) async {
    return await _getAllSaleForEventUseCase(eventObjectId);
  }
}
