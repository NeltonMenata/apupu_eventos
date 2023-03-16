import 'package:apupu_eventos/layers/data/datasources/back4app/get_all_event_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/mock/get_all_event_datasource_mock_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/get_all_event/get_all_event_repository_imp.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/event/get_all_event_usecase/get_all_event_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/event/get_all_event_usecase/get_all_event_usecase_imp.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/cupertino.dart';

class ManagerEventController {
  final IGetAllEventUseCase _getAllEventUseCase = GetAllEventUseCaseImp(
    GetAllEventRepositoryImp(
      GetAllEventDataSourceBack4appImp(),
    ),
  );

  final List<EventEntity> _eventList = [];
  List<EventEntity> get eventList => _eventList;

  Future<List<EventEntity>> getAllEvent(BuildContext context) async {
    try {
      return await _getAllEventUseCase();
    } catch (e) {
      showResultCustom(
          context, "Erro ao carregar os eventos guardados: " + e.toString());
      return [];
    }
  }
}
