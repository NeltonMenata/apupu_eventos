import 'package:apupu_eventos/layers/data/datasources/back4app/worker/create_worker/create_worker_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/create_worker/create_worker_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/create_worker/create_worker_usecase_imp.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../../data/repositories_imp/worker/create_worker/create_worker_repository_imp.dart';

class CreateWorkerController {
  final ICreateWorkerUseCase _createWorkertUseCase = CreateWorkerUseCaseImp(
    CreateWorkerRepositoryImp(
      CreateWorkerDataSourceBack4appImp(),
    ),
  );

  Future<void> createWorker(
    BuildContext context, {
    required String name,
    required String username,
    required String password,
    required bool isDoorman,
  }) async {
    name.trim();
    username.trim();
    password.trim();

    try {
      //await Future.delayed(Duration(seconds: 3));

      final result = await _createWorkertUseCase(WorkerEntity(
          objectId: "",
          name: name,
          username: username,
          password: password,
          isDoorman: isDoorman));
      if (result.objectId == "error") {
        showResultCustom(context, result.name, isError: true);
      } else {
        showResultCustom(context, "Trabalhador Salvo com sucesso");
      }
    } catch (e) {
      showResultCustom(context, "Erro ao Salvar Trabalhador: " + e.toString(),
          isError: true);
    }
  }
}
