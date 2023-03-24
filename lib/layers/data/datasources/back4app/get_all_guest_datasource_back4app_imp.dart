import 'package:apupu_eventos/layers/data/datasources/mock/database_mock.dart';
import '../../../domain/entities/guest/guest_entity.dart';
import '../get_all_guest_datasource.dart';

class GetAllGuestDataSourceBack4appImp implements IGetAllGuestDataSource {
  @override
  Future<List<GuestEntity>> call() async {
    return DataBaseMock.listGuestEntity;
  }
}
