import 'package:apupu_eventos/layers/data/datasources/worker/get_all_worker/get_all_worker_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity.dart';
import 'package:apupu_eventos/layers/domain/repositories/worker/get_all_worker/get_all_worker_repository.dart';

class GetAllWorkerRepositoryImp implements IGetAllWorkerRepository {
  final IGetAllWorkerDataSource _getAllWorkerDataSource;
  GetAllWorkerRepositoryImp(this._getAllWorkerDataSource);
  @override
  Future<List<WorkerEntity>> call([String? managerObjectId]) async {
    return await _getAllWorkerDataSource(managerObjectId);
  }
}
