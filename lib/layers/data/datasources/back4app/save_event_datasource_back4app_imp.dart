import 'package:apupu_eventos/layers/data/datasources/save_event_datasource.dart';
import 'package:apupu_eventos/layers/data/dtos/event_dto.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class SaveEventDataSourceBack4appImp implements ISaveEventDataSource {
  @override
  Future<EventEntity> call(EventEntity event) async {
    final saveEvent = ParseCloudFunction("saveEvent");
    print(event.dateOfRealization);

    try {
      final result = await saveEvent.execute(parameters: {
        "name": event.name,
        "dateOfRealization": event.dateOfRealization.toIso8601String(),
        "organization": event.organization,
        "price": event.price
      });

      if (result.success) {
        return EventDto.fromMap(result.results![0]);

        // EventDto.fromMap(saveEvent.results![0]);
      }
    } catch (e) {
      return EventEntity(
          objectId: "objectId",
          name: "name",
          dateOfRealization: DateTime.now(),
          organization: "organization",
          imgCatalog: "imgCatalog",
          price: 0);
    }

    /*
    
    const currentUser = request.params.user;
	  const name = request.params.name;
	  const dateOfRealization = request.params.dateOfRealization;
	  const price = request.params.price;
	  const organization = request.params.organization;
    
    */

    return EventEntity(
        objectId: "objectId",
        name: "name",
        dateOfRealization: DateTime.now(),
        organization: "organization",
        imgCatalog: "imgCatalog",
        price: 0);
  }
}
