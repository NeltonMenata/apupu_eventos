import 'package:apupu_eventos/layers/data/datasources/back4app/event/get_all_event_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/event/save_event_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/guest/done_in_or_out_guest_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/guest/get_all_guest_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/guest/get_guest_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/guest/save_guest_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/guest/search_guest_for_contact_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/worker/login_worker/worker_login_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/event/get_all_event_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/event/save_event_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/guest/done_in_or_out_guest_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/guest/get_all_guest_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/guest/get_guest_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/guest/save_guest_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/guest/search_guest_for_contact_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/worker/worker_login/worker_login_datasource.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/event/get_all_event/get_all_event_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/event/save_event/save_event_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/guest/done_in_or_out_guest/done_in_or_out_guest_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/guest/get_all_guest/get_all_event_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/guest/get_guest_for_objectId/get_guest_for_objectId_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/guest/save_guest/save_guest_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/guest/search_guest_for_contact/search_guest_for_contact_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/worker/worker_login/worker_login_repository_imp.dart';
import 'package:apupu_eventos/layers/domain/repositories/event/get_all_event_repository/get_all_event_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/event/save_event/save_event_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/guest/done_in_or_out_guest_repository/done_in_or_out_guest_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/guest/get_all_guest_repository/get_all_event_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/guest/get_guest_for_objectId/get_guest_for_objectId_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/guest/save_guest/save_guest_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/guest/search_guest_for_contact/get_guest_for_objectId_repository.dart';
import 'package:apupu_eventos/layers/domain/usecases/event/get_all_event_usecase/get_all_event_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/event/save_event_usecase/save_event_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/done_in_or_out_guest/done_in_or_out_guest.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/done_in_or_out_guest/done_in_or_out_guest_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/get_all_guest/get_all_guest_entity_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/get_guest_for_objectId_usecase/get_guest_entity_for_objectId.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/save_guest/save_guest_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/search_guest_for_contact/search_guest_entity_for_contact.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/login/login_worker_usecase_imp.dart';
import 'package:apupu_eventos/layers/presenter/ui/add_event/add_event_controller.dart';
import 'package:get_it/get_it.dart';

import '../../domain/repositories/worker/worker_login/worker_login_repository.dart';
import '../../domain/usecases/event/get_all_event_usecase/get_all_event_usecase_imp.dart';
import '../../domain/usecases/event/save_event_usecase/save_event_imp.dart';
import '../../domain/usecases/guest/get_all_guest/get_all_guest_entity_usecase_imp.dart';
import '../../domain/usecases/guest/get_guest_for_objectId_usecase/get_guest_entity_for_objectId_imp.dart';
import '../../domain/usecases/guest/save_guest/save_guest_usecase_imp.dart';
import '../../domain/usecases/guest/search_guest_for_contact/search_guest_entity_for_contact_imp.dart';
import '../../domain/usecases/worker/login/login_worker_usecase.dart';
import '../../presenter/ui/add_guest/add_guest_controller.dart';
import '../../presenter/ui/login/login_controller.dart';
import '../../presenter/ui/manager_event/manager_event_controller.dart';
import '../../presenter/ui/register_in_or_out_guest/register_in_or_out_guest_controller.dart';
import '../../presenter/ui/search_guest/search_guest_controller.dart';

class Inject {
  static void init() {
    GetIt getIt = GetIt.I;
    //HTTP

    //DATASOURCE
    //######### - Guest - DATASOURCE
    getIt.registerSingleton<IDoneInOrOutGuestDataSource>(
      DoneInOrOutGuestDatasourceBack4appImp(),
    );
    getIt.registerSingleton<IGetAllGuestDataSource>(
      GetAllGuestDataSourceBack4appImp(),
    );
    getIt.registerSingleton<IGetGuestDataSource>(
      GetGuestDataSourceBack4appImp(),
    );
    getIt.registerSingleton<ISaveGuestDataSource>(
      SaveGuestDataSourceBack4appImp(),
    );
    getIt.registerSingleton<ISearchGuestForContactDataSource>(
      SearchGuestForContactDataSourceBack4appImp(),
    );

    //######### - Event - DATASOURCE
    getIt.registerSingleton<IGetAllEventDataSource>(
      GetAllEventDataSourceBack4appImp(),
    );
    getIt.registerSingleton<ISaveEventDataSource>(
      SaveEventDataSourceBack4appImp(),
    );
    //######## - Worker - DATASOURCE
    getIt.registerSingleton<IWorkerLoginDataSource>(
        WorkerLoginDataSourceBack4appImp());
    //REPOSITORY
    //######## - Guest - REPOSITORY
    getIt.registerSingleton<IDoneInOrOutGuestRepository>(
      DoneInOrOutGuestRepositoryImp(
        getIt(),
      ),
    );
    getIt.registerSingleton<IGetAllGuestRepository>(
      GetAllGuestRepositoryImp(
        getIt(),
      ),
    );
    getIt.registerSingleton<IGetGuestForObjectIdRepository>(
      GetGuestForObjectIdRepositoryImp(
        getIt(),
      ),
    );
    getIt.registerSingleton<ISaveGuestRepository>(
      SaveGuestRepositoryImp(
        getIt(),
      ),
    );
    getIt.registerSingleton<ISearchGuestForContactRepository>(
      SearchGuestForContactRepositoryImp(
        getIt(),
      ),
    );
    //####### - Event - REPOSITORY

    getIt.registerSingleton<IGetAllEventRepository>(
      GetAllEventRepositoryImp(
        getIt(),
      ),
    );
    getIt.registerSingleton<ISaveEventRepository>(
      SaveEventRepositoryImp(
        getIt(),
      ),
    );

    //####### - Worker - REPOSITORY
    getIt.registerSingleton<IWorkerLoginRepository>(
        WorkerLoginRepositoryImp(WorkerLoginDataSourceBack4appImp()));
    //USECASE
    //####### - Guest - USECASE
    getIt.registerSingleton<IDoneInOrOutGuestUseCase>(
      DoneInOrOutGuestUseCaseImp(
        getIt(),
      ),
    );
    getIt.registerSingleton<IGetAllGuestUseCase>(
      GetAllGuestUseCaseImp(
        getIt(),
      ),
    );
    getIt.registerSingleton<IGetGuestForObjectIdUseCase>(
      GetGuestForObjectIdUseCaseImp(
        getIt(),
      ),
    );
    getIt.registerSingleton<ISaveGuestUseCase>(
      SaveGuestUseCaseImp(
        getIt(),
      ),
    );
    getIt.registerSingleton<ISearchGuestForContactUseCase>(
      SearchGuestForContactUseCaseImp(
        getIt(),
      ),
    );
    //####### - Event - USECASE
    getIt.registerSingleton<IGetAllEventUseCase>(
      GetAllEventUseCaseImp(
        getIt(),
      ),
    );
    getIt.registerSingleton<ISaveEventUseCase>(
      SaveEventUseCaseImp(
        getIt(),
      ),
    );
    //####### - Worker - USECASE
    getIt.registerSingleton<ILoginWorkerUseCase>(
      LoginWorkerUseCaseImp(
        getIt(),
      ),
    );

    //CONTROLLER
    getIt.registerFactory<AddEventController>(() => AddEventController());
    getIt.registerFactory<AddGuestController>(() => AddGuestController());
    getIt.registerFactory<LoginController>(() => LoginController());
    getIt.registerFactory<ManagerEventController>(() => ManagerEventController(
          GetAllEventUseCaseImp(
            GetAllEventRepositoryImp(
              GetAllEventDataSourceBack4appImp(),
            ),
          ),
        ));
    getIt.registerFactory<RegisterInOrOutGuestController>(
        () => RegisterInOrOutGuestController(getIt(), getIt()));
    getIt.registerFactory<SearchGuestController>(
        () => SearchGuestController(getIt()));
  }
}
