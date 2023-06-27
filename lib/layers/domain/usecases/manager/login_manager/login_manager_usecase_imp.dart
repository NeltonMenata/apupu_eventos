import 'package:apupu_eventos/layers/domain/entities/manager/manager_entity.dart';
import '../../../repositories/manager/login_manager/login_manager_repository.dart';
import 'login_manager_usecase.dart';

class LoginManagerUseCaseImp implements ILoginManagerUseCase {
  final ILoginManagerRepository _managerLoginRepository;
  LoginManagerUseCaseImp(this._managerLoginRepository);
  @override
  Future<ManagerEntity> call(String username, String password) async {
    return await _managerLoginRepository(username, password);
  }
}
