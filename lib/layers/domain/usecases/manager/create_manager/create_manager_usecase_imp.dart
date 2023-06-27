import 'package:apupu_eventos/layers/domain/entities/manager/manager_entity.dart';

import '../../../repositories/manager/create_manager/create_manager_repository.dart';
import 'create_manager_usecase.dart';

class CreateManagerUseCaseImp implements ICreateManagerUseCase {
  final ICreateManagerRepository _createManagerRepository;
  CreateManagerUseCaseImp(this._createManagerRepository);
  @override
  Future<ManagerEntity> call(ManagerEntity manager) async {
    return await _createManagerRepository(manager);
  }
}
