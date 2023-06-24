import '../../../entities/report_guest/report_guest_entity.dart';

abstract class ICountGuestForEventRepository {
  Future<ReportGuestEntity> call(String eventObjectId);
}
