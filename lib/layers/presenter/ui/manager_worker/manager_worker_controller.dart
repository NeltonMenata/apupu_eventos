import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/get_all_worker/get_all_worker_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/remove_worker_event/remove_worker_event_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/verify_worker_event/verify_worker_event_usecase.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/usecases/worker/add_worker_event/add_worker_event_usecase.dart';

class ManagerWorkerController {
  ManagerWorkerController(
      this._getAllWorkerUseCase,
      this._verifyWorkerEventUseCase,
      this._addWorkerEventUseCase,
      this._removeWorkerEventUseCase);
  final IGetAllWorkerUseCase _getAllWorkerUseCase;
  final IVerifyWorkerEventUseCase _verifyWorkerEventUseCase;
  final IAddWorkerEventUseCase _addWorkerEventUseCase;
  final IRemoveWorkerEventUseCase _removeWorkerEventUseCase;
  final List<WorkerEntity> _workerList = [];
  List<WorkerEntity> get workerList => _workerList;

  Future<List<WorkerEntity>> getAllWorker(BuildContext context,
      [String? workerObjectId]) async {
    try {
      return await _getAllWorkerUseCase();
    } catch (e) {
      showResultCustom(context, e.toString());
      return [];
    }
  }

  Future<bool> verifyWorkerEvent(
      String workerObjectId, String eventObjectId) async {
    return _verifyWorkerEventUseCase(workerObjectId, eventObjectId);
  }

  Future<bool> removeWorkerEvent(
      String workerObjectId, String eventObjectId) async {
    return _removeWorkerEventUseCase(workerObjectId, eventObjectId);
  }

  Future<bool> addWorkerEvent(
      String workerObjectId, String eventObjectId) async {
    return _addWorkerEventUseCase(workerObjectId, eventObjectId);
  }
}

class ActionWorkerEvent extends ValueNotifier<bool> {
  ActionWorkerEvent() : super(false);
}

abstract class WorkerEventState {}

class SucessWorkerEvent implements WorkerEventState {
  final bool successValue;

  SucessWorkerEvent(this.successValue);
}

class LoadingWorkerEvent implements WorkerEventState {}
