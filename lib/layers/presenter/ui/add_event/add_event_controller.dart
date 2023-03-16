import 'package:apupu_eventos/layers/data/datasources/back4app/save_event_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/save_event/save_event_repository_imp.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/event/save_event_usecase/save_event_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/event/save_event_usecase/save_event_usecase.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../data/datasources/mock/save_event_datasource_mock_imp.dart';

class AddEventController {
  final ISaveEventUseCase _saveEventUseCase = SaveEventUseCaseImp(
    SaveEventRepositoryImp(
      SaveEventDataSourceBack4appImp(),
    ),
  );

  Future<void> saveEvent(BuildContext context, String name,
      DateTime dateOfRealization, String organization, double price) async {
    name.trim();
    organization.trim();

    try {
      //await Future.delayed(Duration(seconds: 3));
      final event = EventEntity(
          objectId: "",
          name: name,
          dateOfRealization: dateOfRealization,
          imgCatalog: "",
          organization: organization,
          price: price);
      await _saveEventUseCase(event);
      showResultCustom(context, "Evento Salvo com sucesso");
    } catch (e) {
      showResultCustom(context, "Erro ao salvar evento: " + e.toString());
    }
  }
}
