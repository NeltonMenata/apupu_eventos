import 'package:apupu_eventos/layers/data/dtos/event_dto.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../../../domain/entities/event/event_entity.dart';
import '../../event/get_all_event_datasource.dart';

class GetAllEventDataSourceBack4appImp implements IGetAllEventDataSource {
  @override
  Future<List<EventEntity>> call([String? workerObjectId]) async {
    final functionAllEvent = ParseCloudFunction("getAllEvent");
    final allEvent = await functionAllEvent
        .execute(parameters: {"workerObjectId": workerObjectId});
    if (allEvent.statusCode == 200) {
      final List<EventDto> list = [];
      allEvent.result.forEach((e) {
        list.add(
          EventDto(
            dateOfRealization: DateTime.parse(e["dateOfRealization"]["iso"]),
            imgCartaz: e["imgCartaz"],
            name: e["name"].toString(),
            objectId: e["objectId"].toString(),
            organization: e["organization"].toString(),
            price: double.parse(
              e["price"].toString(),
            ),
          ),
        );
      });

      return list;
    }
    return [
      EventDto(
          dateOfRealization: DateTime.now(),
          imgCartaz: Utils.assetLogo,
          name: "Sem Internet",
          objectId: "",
          organization: "",
          price: 0)
    ];
  }
}
