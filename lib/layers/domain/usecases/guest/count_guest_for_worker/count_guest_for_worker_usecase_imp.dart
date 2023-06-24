import '../../../entities/report_guest/report_guest_entity.dart';
import '../../../repositories/guest/count_guest_for_worker/count_guest_for_worker_repository.dart';
import 'count_guest_for_worker_usecase.dart';

class CountGuestForWorkerUseCaseImp implements ICountGuestForWorkerUseCase {
  final ICountGuestForWorkerRepository _countGuestForWorkerRepository;
  CountGuestForWorkerUseCaseImp(this._countGuestForWorkerRepository);
  @override
  Future<List<ReportGuestEntity>> call(
      String workerObjectId, String eventObjectId) async {
    return await _countGuestForWorkerRepository(workerObjectId, eventObjectId);
  }
}
