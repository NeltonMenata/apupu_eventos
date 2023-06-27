import 'package:apupu_eventos/layers/domain/entities/manager/manager_entity.dart';
import '../../../../domain/repositories/manager/login_manager/login_manager_repository.dart';
import '../../../datasources/manager/login_manager/login_manager_datasource.dart';

class LoginManagerRepositoryImp implements ILoginManagerRepository {
  final ILoginManagerDataSource _loginManagerDataSource;
  LoginManagerRepositoryImp(this._loginManagerDataSource);
  @override
  Future<ManagerEntity> call(String username, String password) async {
    return await _loginManagerDataSource(username, password);
  }
}
