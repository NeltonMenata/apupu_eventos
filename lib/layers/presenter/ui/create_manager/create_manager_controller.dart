import 'package:apupu_eventos/layers/domain/entities/manager/manager_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/manager/create_manager/create_manager_usecase.dart';

class CreateManagerController {
  final ICreateManagerUseCase _createManagerUseCase;
  CreateManagerController(this._createManagerUseCase);

  Future<ManagerEntity> createManager(ManagerEntity manager) async {
    return await _createManagerUseCase(manager);
  }
}
