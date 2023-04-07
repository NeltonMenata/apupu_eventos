import 'package:apupu_eventos/layers/data/datasources/guest/count_guest_for_event_datasource.dart';
import 'package:apupu_eventos/layers/domain/repositories/guest/count_guest_for_event/count_guest_for_event_repository.dart';

import '../../../../domain/repositories/guest/count_guest_for_worker/count_guest_for_worker_repository.dart';
import '../../../datasources/guest/count_guest_for_worker_datasource.dart';

class CountGuestForWorkerRepositoryImp
    implements ICountGuestForWorkerRepository {
  final ICountGuestForWorkerDataSource _countGuestForWorkerDataSource;
  CountGuestForWorkerRepositoryImp(this._countGuestForWorkerDataSource);
  Future<int> call(String workerObjectId, String eventObjectId) async {
    return await _countGuestForWorkerDataSource(workerObjectId, eventObjectId);
  }
}
