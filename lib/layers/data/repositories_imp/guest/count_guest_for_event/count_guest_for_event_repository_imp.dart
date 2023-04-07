import 'package:apupu_eventos/layers/data/datasources/guest/count_guest_for_event_datasource.dart';
import 'package:apupu_eventos/layers/domain/repositories/guest/count_guest_for_event/count_guest_for_event_repository.dart';

class CountGuestForEventRepositoryImp implements ICountGuestForEventRepository {
  final ICountGuestForEventDataSource _countGuestForEventDataSource;
  CountGuestForEventRepositoryImp(this._countGuestForEventDataSource);
  Future<int> call(String eventObjectId) async {
    return await _countGuestForEventDataSource(eventObjectId);
  }
}
