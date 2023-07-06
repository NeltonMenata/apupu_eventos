import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';

abstract class IGetEventRepository {
  Future<EventEntity> call(String eventObjectId);
}
