import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/event/save_event_usecase/save_event_usecase.dart';

import '../../../repositories/event/save_event/save_event_repository.dart';

class SaveEventUseCaseImp implements ISaveEventUseCase {
  final ISaveEventRepository _saveEventRepository;

  SaveEventUseCaseImp(this._saveEventRepository);

  @override
  Future<EventEntity> call(EventEntity event) async {
    return await _saveEventRepository(event);
  }
}
