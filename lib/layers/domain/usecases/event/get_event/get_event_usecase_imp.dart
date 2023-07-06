import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/domain/repositories/event/get_event/get_event_repository.dart';
import 'package:apupu_eventos/layers/domain/usecases/event/get_event/get_event_usecase.dart';

class GetEventUseCaseImp implements IGetEventUseCase {
  final IGetEventRepository _getEventRepository;

  GetEventUseCaseImp(this._getEventRepository);
  @override
  Future<EventEntity> call(String eventObjectId) async {
    return await _getEventRepository(eventObjectId);
  }
}
