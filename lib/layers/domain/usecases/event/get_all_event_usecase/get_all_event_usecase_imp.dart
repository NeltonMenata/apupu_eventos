import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/domain/repositories/get_all_event_repository/get_all_event_repository.dart';
import 'package:apupu_eventos/layers/domain/usecases/event/get_all_event_usecase/get_all_event_usecase.dart';

class GetAllEventUseCaseImp implements IGetAllEventUseCase {
  final IGetAllEventRepository _getAllEventRepository;
  GetAllEventUseCaseImp(this._getAllEventRepository);
  @override
  Future<List<EventEntity>> call() async {
    return await _getAllEventRepository();
  }
}
