import 'package:apupu_eventos/layers/data/datasources/event/get_all_event_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/mock/database_mock.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';

class GetAllEventDataSourceMockImp implements IGetAllEventDataSource {
  @override
  Future<List<EventEntity>> call(
      [String? workerObjectId, String? managerObjectId]) async {
    return DataBaseMock.listEventEntity;
  }
}
