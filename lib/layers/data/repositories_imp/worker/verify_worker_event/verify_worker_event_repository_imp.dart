import 'package:apupu_eventos/layers/domain/repositories/worker/verify_worker_event/verify_worker_event_repository.dart';

import '../../../datasources/worker/verify_worker_event/verify_worker_event_datasource.dart';

class VerifyWorkerEventRepositoryImp implements IVerifyWorkerEventRepository {
  final IVerifyWorkerEventDataSource _verifyWorkerEventDataSource;
  VerifyWorkerEventRepositoryImp(this._verifyWorkerEventDataSource);
  @override
  Future<bool> call(String workerObjectId, String eventObjectId) async {
    return await _verifyWorkerEventDataSource(workerObjectId, eventObjectId);
  }
}
