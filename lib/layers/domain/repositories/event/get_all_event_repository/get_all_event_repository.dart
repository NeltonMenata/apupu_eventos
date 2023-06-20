import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';

abstract class IGetAllEventRepository {
  Future<List<EventEntity>> call(
      [String? workerObjectId, String? managerObjectId]);
}
