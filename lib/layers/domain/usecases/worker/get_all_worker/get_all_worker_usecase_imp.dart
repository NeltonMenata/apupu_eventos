import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity.dart';
import 'package:apupu_eventos/layers/domain/repositories/worker/get_all_worker/get_all_worker_repository.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/get_all_worker/get_all_worker_usecase.dart';

class GetAllWorkerUseCaseImp implements IGetAllWorkerUseCase {
  final IGetAllWorkerRepository _getAllWorkerRepository;
  GetAllWorkerUseCaseImp(this._getAllWorkerRepository);
  @override
  Future<List<WorkerEntity>> call() async {
    return await _getAllWorkerRepository();
  }
}
