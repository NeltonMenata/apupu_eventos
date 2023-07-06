import 'package:apupu_eventos/layers/data/datasources/event/get_event_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class GetEventDataSourceBack4appImp implements IGetEventDataSource {
  @override
  Future<EventEntity> call(String eventObjectId) async {
    final event = ParseCloudFunction("getEvent");

    try {
      final getEvent = await event.execute(parameters: {
        "eventObjectId": eventObjectId,
      });

      if (getEvent.success) {
        if (getEvent.result["error"] != null) {
          return EventEntity(
              objectId: "objectId",
              name: "name",
              dateOfRealization: DateTime.now(),
              organization: "organization",
              imgCartaz: "imgCatalog",
              error: getEvent.result["error"].toString(),
              price: 0);
        } else {
          return EventEntity(
            objectId: getEvent.result["objectId"],
            price: getEvent.result["price"],
            priceVip: getEvent.result["priceVip"],
            payment: getEvent.result["payment"],
            name: getEvent.result["name"],
            normal: getEvent.result["normal"],
            vip: getEvent.result["vip"],
            productsQuantity: getEvent.result["productsQuantity"],
            productsValue: getEvent.result["productsValue"],
            dateOfRealization: DateTime.tryParse(
                    getEvent.result["dateOfRealization"]["iso"]) ??
                DateTime.now(),
            organization: getEvent.result["organization"],
          );
        }
      } else {
        return EventEntity(
            objectId: "objectId",
            name: "name",
            dateOfRealization: DateTime.now(),
            organization: "organization",
            imgCartaz: "imgCatalog",
            error: getEvent.error?.message,
            price: 0);
      }
    } catch (e) {
      return EventEntity(
          objectId: "objectId",
          name: "name",
          dateOfRealization: DateTime.now(),
          organization: "organization",
          imgCartaz: "imgCatalog",
          error: e.toString(),
          price: 0);
    }
  }
}
