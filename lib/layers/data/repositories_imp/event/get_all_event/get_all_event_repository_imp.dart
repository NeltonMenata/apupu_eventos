import 'package:apupu_eventos/layers/data/datasources/event/get_all_event_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import '../../../../domain/repositories/event/get_all_event_repository/get_all_event_repository.dart';

class GetAllEventRepositoryImp implements IGetAllEventRepository {
  final IGetAllEventDataSource _getAllEventDataSource;

  GetAllEventRepositoryImp(this._getAllEventDataSource);

  @override
  Future<List<EventEntity>> call([String? workerObjectId]) async {
    return _getAllEventDataSource(workerObjectId);
  }
}
