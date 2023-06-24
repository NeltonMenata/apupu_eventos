import '../../../entities/report_guest/report_guest_entity.dart';

abstract class ICountGuestForWorkerRepository {
  Future<List<ReportGuestEntity>> call(
      String workerObjectId, String eventObjectId);
}
