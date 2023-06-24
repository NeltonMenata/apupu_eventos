import '../../../domain/entities/report_guest/report_guest_entity.dart';

abstract class ICountGuestForEventDataSource {
  Future<ReportGuestEntity> call(String eventObjectId);
}
