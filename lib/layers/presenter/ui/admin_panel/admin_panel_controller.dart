import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/event/confirm_payment_event/confirm_payment_event_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/event/get_event/get_event_usecase.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class AdminPanelController {
  final IConfirmPaymentEventUseCase _confirmPaymentEventUseCase;
  final IGetEventUseCase _getEventUseCase;

  AdminPanelController(this._confirmPaymentEventUseCase, this._getEventUseCase);
  openCallPhone(String phoneNumber) {}
  openWhatsapp(String phoneNumber, String sms) async {}

  Future<bool> confirmPaymentEvent(String eventObjectId) async {
    return _confirmPaymentEventUseCase(eventObjectId);
  }

  Future<EventEntity?> getEvent(
      BuildContext context, String eventObjectId) async {
    try {
      final event = await _getEventUseCase(eventObjectId);
      if (event.error != null) {
        showResultCustom(context, "Erro ao Buscar evento.\n\n${event.error}",
            isError: true);
        return null;
      } else {
        return event;
      }
    } catch (e) {
      showResultCustom(context, "Erro ao Buscar evento: " + e.toString());
      return null;
    }
  }
}
