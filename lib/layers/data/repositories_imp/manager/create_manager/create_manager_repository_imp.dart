import 'package:apupu_eventos/layers/domain/entities/manager/manager_entity.dart';
import '../../../../domain/repositories/manager/create_manager/create_manager_repository.dart';
import '../../../datasources/manager/create_manager/create_manager_datasource.dart';

class CreateManagerRepositoryImp implements ICreateManagerRepository {
  final ICreateManagerDataSource _createManagerDataSource;
  CreateManagerRepositoryImp(this._createManagerDataSource);
  @override
  Future<ManagerEntity> call(ManagerEntity manager) async {
    return await _createManagerDataSource(manager);
  }
}
