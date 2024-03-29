import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';

abstract class IGetEventDataSource {
  Future<EventEntity> call(String eventObjectId);
}
