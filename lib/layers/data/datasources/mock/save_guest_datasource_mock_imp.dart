import 'package:apupu_eventos/layers/data/datasources/mock/database_mock.dart';
import 'package:apupu_eventos/layers/data/dtos/guest_dto.dart';
import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../save_guest_datasource.dart';

class SaveGuestDataSourceMockImp implements ISaveGuestDataSource {
  final List<GuestEntity> list = [];

  @override
  Future<GuestEntity> call(GuestEntity guestEntity) async {
    DataBaseMock.listGuestEntity.add(guestEntity);
    return DataBaseMock.listGuestEntity.last;
  }
}
