import '../../../domain/entities/report_guest/report_guest_entity.dart';

abstract class ICountGuestForWorkerDataSource {
  Future<List<ReportGuestEntity>> call(
      String workerObjectId, String eventObjectId);
}
