import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';

abstract class IGetAllEventUseCase {
  Future<List<EventEntity>> call([String? workerObjectId]);
}
