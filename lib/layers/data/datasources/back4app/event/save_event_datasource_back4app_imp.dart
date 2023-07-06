import 'dart:io';
import 'package:apupu_eventos/layers/data/datasources/event/save_event_datasource.dart';
import 'package:apupu_eventos/layers/data/dtos/event_dto.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class SaveEventDataSourceBack4appImp implements ISaveEventDataSource {
  @override
  Future<EventEntity> call(EventEntity event) async {
    final saveEvent = ParseCloudFunction("saveEvent");

    try {
      ParseFileBase? imgFile;
      if (event.imgCartaz != null) {
        imgFile = ParseFile(File(event.imgCartaz!));
        await imgFile.save();
      }
      final result = await saveEvent.execute(parameters: {
        "name": event.name,
        "dateOfRealization": event.dateOfRealization.toIso8601String(),
        "organization": event.organization,
        "price": event.price,
        "priceVip": event.priceVip,
        //"managerObjectId": event.managerObjectId,
        "imgCartaz": imgFile?.url,
        "bonusCredit": event.bonusCredit
      });

      if (result.success) {
        if (result.result["error"] != null) {
          return EventEntity(
              objectId: "objectId",
              name: "name",
              dateOfRealization: DateTime.now(),
              organization: "organization",
              imgCartaz: "imgCatalog",
              error: result.result["error"].toString(),
              price: 0);
        } else {
          return EventDto.fromMap(result.result);
        }
      } else {
        return EventEntity(
            objectId: "objectId",
            name: "name",
            dateOfRealization: DateTime.now(),
            organization: "organization",
            imgCartaz: "imgCatalog",
            error: result.error?.message,
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
