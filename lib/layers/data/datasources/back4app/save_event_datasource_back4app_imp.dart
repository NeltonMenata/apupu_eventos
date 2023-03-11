import 'package:apupu_eventos/layers/data/datasources/save_event_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';

class SaveEventDataSourceBack4appImp implements ISaveEventDataSource {
  @override
  Future<EventEntity> call(EventEntity event) async {
    return EventEntity(
        objectId: "objectId",
        name: "name",
        dateOfrealization: DateTime.now(),
        imgCatalog: "imgCatalog",
        price: 0);
  }
}
