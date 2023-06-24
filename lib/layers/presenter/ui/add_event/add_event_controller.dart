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
      String? managerObjectId,
      int? priceVip,
      required int price,
      File? imgCartaz,
      int? bonusCredit}) async {
    try {
      //await Future.delayed(Duration(seconds: 3));

      final event = EventEntity(
          objectId: "",
          name: name.trim(),
          dateOfRealization: dateOfRealization,
          managerObjectId: managerObjectId,
          imgCartaz: imgCartaz?.path,
          priceVip: priceVip,
          organization: organization.trim(),
          price: price,
          bonusCredit: bonusCredit);
      final result = await _saveEventUseCase(event);
      if (result.error != null) {
        showResultCustom(context, "Erro ao Salvar evento.\n\n${result.error}",
            isError: true);
      } else {
        showResultCustom(context, "Evento Salvo com sucesso");
      }
    } catch (e) {
      showResultCustom(context, "Erro ao salvar evento: " + e.toString());
    }
  }
}
