import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';

abstract class IGetAllEventDataSource {
  Future<List<EventEntity>> call();
}
