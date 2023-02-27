import 'package:apupu_eventos/layers/data/datasources/mock/save_event_datasource_mock_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/save_event/save_event_repository_imp.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/event/save_event_usecase/save_event_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/event/save_event_usecase/save_event_usecase.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';

class AddEventController {
  final ISaveEventUseCase _saveEventUseCase = SaveEventUseCaseImp(
    SaveEventRepositoryImp(
      SaveEventDataSourceMockImp(),
    ),
  );

  Future<void> saveEvent(
      BuildContext context, String name, DateTime dateOfRealization) async {
    name.trim();

    try {
      await _saveEventUseCase(
        EventEntity(
          objectId: "",
          name: name,
          dateOfrealization: dateOfRealization,
          imgCatalog: "",
        ),
      );
      showResultCustom(context, "Evento Salvo com sucesso");
    } catch (e) {
      showResultCustom(context, "Erro ao salvar evento: " + e.toString());
    }
  }
}
