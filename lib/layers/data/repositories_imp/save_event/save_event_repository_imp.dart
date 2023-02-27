import 'package:apupu_eventos/layers/data/datasources/save_event_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/domain/repositories/save_event/save_event_repository.dart';

class SaveEventRepositoryImp implements ISaveEventRepository {
  final ISaveEventDataSource _saveEventDataSource;

  SaveEventRepositoryImp(this._saveEventDataSource);

  @override
  Future<EventEntity> call(EventEntity event) async {
    return await _saveEventDataSource(event);
  }
}
