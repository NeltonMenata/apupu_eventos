import 'package:apupu_eventos/layers/data/datasources/mock/database_mock.dart';
import 'package:apupu_eventos/layers/data/datasources/event/save_event_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';

class SaveEventDataSourceMockImp implements ISaveEventDataSource {
  @override
  Future<EventEntity> call(EventEntity event) async {
    DataBaseMock.listEventEntity.add(event);

    return DataBaseMock.listEventEntity.last;
  }
}
