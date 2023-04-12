import 'dart:io';
import 'package:apupu_eventos/layers/core/inject/inject.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/event/save_event_usecase/save_event_usecase.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';

class AddEventController {
  final ISaveEventUseCase _saveEventUseCase = getIt<ISaveEventUseCase>();

  Future<void> saveEvent(BuildContext context,
      {required String name,
      required DateTime dateOfRealization,
      required String organization,
      required double price,
      File? imgCartaz}) async {
    name.trim();
    organization.trim();

    try {
      //await Future.delayed(Duration(seconds: 3));

      final event = EventEntity(
          objectId: "",
          name: name,
          dateOfRealization: dateOfRealization,
          imgCartaz: imgCartaz?.path,
          organization: organization,
          price: price);
      final result = await _saveEventUseCase(event);
      if (result.name == "name" && result.organization == "organization") {
        showResultCustom(context, "Erro ao Salvar evento.", isError: true);
      } else {
        showResultCustom(context, "Evento Salvo com sucesso");
      }
    } catch (e) {
      showResultCustom(context, "Erro ao salvar evento: " + e.toString());
    }
  }
}
