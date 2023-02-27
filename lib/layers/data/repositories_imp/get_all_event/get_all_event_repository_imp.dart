import 'package:apupu_eventos/layers/data/datasources/get_all_event_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/domain/repositories/get_all_event_repository/get_all_event_repository.dart';

class GetAllEventRepositoryImp implements IGetAllEventRepository {
  final IGetAllEventDataSource _getAllEventDataSource;

  GetAllEventRepositoryImp(this._getAllEventDataSource);

  @override
  Future<List<EventEntity>> call() async {
    return _getAllEventDataSource();
  }
}
