import 'package:apupu_eventos/layers/data/datasources/guest/count_guest_for_event_datasource.dart';
import 'package:apupu_eventos/layers/domain/repositories/guest/count_guest_for_event/count_guest_for_event_repository.dart';

import '../../../../domain/entities/report_guest/report_guest_entity.dart';

class CountGuestForEventRepositoryImp implements ICountGuestForEventRepository {
  final ICountGuestForEventDataSource _countGuestForEventDataSource;
  CountGuestForEventRepositoryImp(this._countGuestForEventDataSource);
  @override
  Future<ReportGuestEntity> call(String eventObjectId) async {
    return await _countGuestForEventDataSource(eventObjectId);
  }
}
