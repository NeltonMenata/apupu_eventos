import 'package:apupu_eventos/layers/data/datasources/back4app/credit/get_all_credit_for_event_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/credit/make_credit_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/event/get_all_event_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/event/save_event_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/guest/count_guest_for_event_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/guest/count_guest_for_worker_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/guest/done_in_or_out_guest_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/guest/get_all_guest_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/guest/get_guest_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/guest/save_guest_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/guest/search_guest_for_contact_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/manager/create_manager/create_manager_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/manager/login_manager/login_manager_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/product/get_all_product_datasorce_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/product/save_product_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/sale/make_sale_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/worker/add_worker_event/add_worker_event_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/worker/create_worker/create_worker_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/worker/get_all_worker/get_all_worker_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/worker/get_all_worker_in_event/get_all_worker_in_event_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/worker/login_worker/worker_login_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/worker/remove_worker_event/remove_worker_event_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/worker/verify_worker_event/verify_worker_event_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/credit/get_all_credit_for_event_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/credit/make_credit_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/event/get_all_event_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/event/save_event_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/guest/count_guest_for_event_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/guest/count_guest_for_worker_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/guest/done_in_or_out_guest_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/guest/get_all_guest_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/guest/get_guest_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/guest/save_guest_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/guest/search_guest_for_contact_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/manager/create_manager/create_manager_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/manager/login_manager/login_manager_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/product/get_all_product_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/product/save_product_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/sale/make_sale_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/worker/add_worker_event/add_worker_event_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/worker/create_worker/create_worker_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/worker/get_all_worker/get_all_worker_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/worker/get_all_worker_in_event/get_all_worker_in_event_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/worker/remove_worker_event/remove_worker_event_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/worker/verify_worker_event/verify_worker_event_datasource.dart';
import 'package:apupu_eventos/layers/data/datasources/worker/worker_login/worker_login_datasource.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/credit/get_all_credit_for_event_repository/get_all_credit_for_event_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/credit/make_credit/make_credit_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/event/get_all_event/get_all_event_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/event/save_event/save_event_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/guest/count_guest_for_event/count_guest_for_event_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/guest/count_guest_for_worker/count_guest_for_worker_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/guest/done_in_or_out_guest/done_in_or_out_guest_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/guest/get_all_guest/get_all_event_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/guest/get_guest_for_objectId/get_guest_for_objectId_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/guest/save_guest/save_guest_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/guest/search_guest_for_contact/search_guest_for_contact_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/manager/create_manager/create_manager_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/manager/login_manager/login_manager_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/product/get_all_product/get_all_product_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/product/save_product/save_product_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/sale/make_sale/make_sale_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/worker/add_worker_event/add_worker_event_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/worker/create_worker/create_worker_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/worker/get_all_worker/get_all_worker_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/worker/get_all_worker_in_event/get_all_worker_in_event_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/worker/remove_worker_event/remove_worker_event_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/worker/verify_worker_event/verify_worker_event_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/worker/worker_login/worker_login_repository_imp.dart';
import 'package:apupu_eventos/layers/domain/repositories/credit/get_all_credit_for_event/get_all_credit_for_event_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/credit/make_credit/make_credit_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/event/get_all_event_repository/get_all_event_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/event/save_event/save_event_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/guest/count_guest_for_event/count_guest_for_event_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/guest/count_guest_for_worker/count_guest_for_worker_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/guest/done_in_or_out_guest_repository/done_in_or_out_guest_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/guest/get_all_guest_repository/get_all_event_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/guest/get_guest_for_objectId/get_guest_for_objectId_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/guest/save_guest/save_guest_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/guest/search_guest_for_contact/get_guest_for_objectId_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/manager/create_manager/create_manager_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/manager/login_manager/login_manager_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/product/save_product/save_product_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/sale/make_sale/make_sale_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/worker/add_worker_event/add_worker_event_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/worker/create_worker/create_worker_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/worker/get_all_worker/get_all_worker_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/worker/get_all_worker_in_event/get_all_worker_in_event_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/worker/remove_worker_event/remove_worker_event_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/worker/verify_worker_event/verify_worker_event_repository.dart';
import 'package:apupu_eventos/layers/domain/repositories/worker/worker_login/worker_login_repository.dart';
import 'package:apupu_eventos/layers/domain/usecases/credit/get_all_credit_for_event/get_all_credit_for_event_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/credit/get_all_credit_for_event/get_all_credit_for_event_usecase_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/credit/make_credit/make_credit_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/credit/make_credit/make_credit_usecase_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/event/get_all_event_usecase/get_all_event_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/event/get_all_event_usecase/get_all_event_usecase_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/event/save_event_usecase/save_event_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/event/save_event_usecase/save_event_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/count_guest_for_event/count_guest_for_event_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/count_guest_for_event/count_guest_for_event_usecase_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/count_guest_for_worker/count_guest_for_worker_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/count_guest_for_worker/count_guest_for_worker_usecase_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/done_in_or_out_guest/done_in_or_out_guest.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/done_in_or_out_guest/done_in_or_out_guest_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/get_all_guest/get_all_guest_entity_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/get_all_guest/get_all_guest_entity_usecase_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/get_guest_for_objectId_usecase/get_guest_entity_for_objectId.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/get_guest_for_objectId_usecase/get_guest_entity_for_objectId_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/save_guest/save_guest_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/save_guest/save_guest_usecase_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/search_guest_for_contact/search_guest_entity_for_contact.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/search_guest_for_contact/search_guest_entity_for_contact_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/manager/create_manager/create_manager_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/manager/create_manager/create_manager_usecase_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/manager/login_manager/login_manager_usecase_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/product/get_all_product/get_all_product_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/product/get_all_product/get_all_product_usecase_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/product/save_product/save_product_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/product/save_product/save_product_usecase_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/sale/make_sale/make_sale_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/sale/make_sale/make_sale_usecase_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/add_worker_event/add_worker_event_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/add_worker_event/add_worker_event_usecase_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/create_worker/create_worker_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/create_worker/create_worker_usecase_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/get_all_worker/get_all_worker_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/get_all_worker/get_all_worker_usecase_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/get_all_worker_in_event/get_all_worker_in_event_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/get_all_worker_in_event/get_all_worker_in_event_usecase_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/login/login_worker_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/login/login_worker_usecase_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/remove_worker_event/remove_worker_event_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/remove_worker_event/remove_worker_event_usecase_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/verify_worker_event/verify_worker_event_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/verify_worker_event/verify_worker_event_usecase_imp.dart';
import 'package:apupu_eventos/layers/presenter/ui/add_event/add_event_controller.dart';
import 'package:apupu_eventos/layers/presenter/ui/add_guest/add_guest_controller.dart';
import 'package:apupu_eventos/layers/presenter/ui/create_manager/create_manager_controller.dart';
import 'package:apupu_eventos/layers/presenter/ui/create_product/create_product_controller.dart';
import 'package:apupu_eventos/layers/presenter/ui/create_worker/create_worker_controller.dart';
import 'package:apupu_eventos/layers/presenter/ui/login/login_controller.dart';
import 'package:apupu_eventos/layers/presenter/ui/make_credit/make_credit_controller.dart';
import 'package:apupu_eventos/layers/presenter/ui/make_sale/make_sale_controller.dart';
import 'package:apupu_eventos/layers/presenter/ui/manager_event/manager_event_controller.dart';
import 'package:apupu_eventos/layers/presenter/ui/manager_worker/manager_worker_controller.dart';
import 'package:apupu_eventos/layers/presenter/ui/register_in_or_out_guest/register_in_or_out_guest_controller.dart';
import 'package:apupu_eventos/layers/presenter/ui/report_event/report_event_controller.dart';
import 'package:apupu_eventos/layers/presenter/ui/search_guest/search_guest_controller.dart';
import 'package:get_it/get_it.dart';

import '../../data/datasources/back4app/sale/get_all_sale_for_event_datasource_back4app_imp.dart';
import '../../data/datasources/sale/get_all_sale_for_event_datasource.dart';
import '../../data/repositories_imp/sale/get_all_sale_for_event/get_all_sale_for_event_repository_imp.dart';
import '../../domain/repositories/product/get_all_product/get_all_product_repository.dart';
import '../../domain/repositories/sale/get_all_sale_for_event/get_all_sale_for_event_repository.dart';
import '../../domain/usecases/manager/login_manager/login_manager_usecase.dart';
import '../../domain/usecases/sale/get_all_sale_for_event/get_all_sale_for_event_usecase.dart';
import '../../domain/usecases/sale/get_all_sale_for_event/get_all_sale_for_event_usecase_imp.dart';

final GetIt getIt = GetIt.I;
void initInject() {
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

  getIt.registerSingleton<ICountGuestForEventDataSource>(
    CountGuestForEventDataSourceBack4appImp(),
  );
  getIt.registerSingleton<ICountGuestForWorkerDataSource>(
    CountGuestForWorkerDataSourceBack4appImp(),
  );
  //######### - Event - DATASOURCE
  getIt.registerSingleton<IGetAllEventDataSource>(
    GetAllEventDataSourceBack4appImp(),
  );
  getIt.registerSingleton<ISaveEventDataSource>(
    SaveEventDataSourceBack4appImp(),
  );
  //######## - Worker - DATASOURCE

  getIt.registerSingleton<IAddWorkerEventDataSource>(
      AddWorkerEventDataSourceBack4appImp());

  getIt.registerSingleton<ICreateWorkerDataSource>(
      CreateWorkerDataSourceBack4appImp());

  getIt.registerSingleton<IGetAllWorkerDataSource>(
      GetAllWorkerDataSourceBack4appImp());

  getIt.registerSingleton<IGetAllWorkerInEventDataSource>(
      GetAllWorkerInEventDataSourceBack4appImp());
  getIt.registerSingleton<IWorkerLoginDataSource>(
      WorkerLoginDataSourceBack4appImp());
  getIt.registerSingleton<IRemoveWorkerEventDataSource>(
      RemoveWorkerEventDataSourceBack4appImp());

  getIt.registerSingleton<IVerifyWorkerEventDataSource>(
      VerifyWorkerEventDataSourceBack4appImp());

  //####### - Manager - DATASOURCE
  getIt.registerSingleton<ILoginManagerDataSource>(
      LoginManagerDataSourceBack4appImp());

  getIt.registerSingleton<ICreateManagerDataSource>(
      CreateManagerDataSourceBack4appImp());

  //####### - Product - DATASOURCE

  getIt.registerSingleton<ISaveProductDataSource>(
      SaveProductDataSourceBack4appImp());

  getIt.registerSingleton<IGetAllProductDataSource>(
      GetAllProductDataSourceBack4appImp());

  //###### - Report - DATASOURCE

  getIt.registerSingleton<IGetAllCreditForEventDataSource>(
      GetAllCreditForEventDataSourceBack4appImp());

  getIt.registerSingleton<IGetAllSaleForEventDataSource>(
      GetAllSaleForEventDataSourceBack4appImp());

  //####### - Credit - DATASOURCE

  getIt.registerSingleton<IMakeCreditDataSource>(
    MakeCreditDataSourceBack4appImp(),
  );

  // - Sale - DATASOURCE

  getIt.registerSingleton<IMakeSaleDataSource>(
    MakeSaleDataSourceBack4appImp(),
  );

  //REPOSITORY
  //######## - Guest - REPOSITORY

  getIt.registerSingleton<ICountGuestForEventRepository>(
      CountGuestForEventRepositoryImp(
    getIt<ICountGuestForEventDataSource>(),
  ));

  getIt.registerSingleton<ICountGuestForWorkerRepository>(
      CountGuestForWorkerRepositoryImp(
    getIt<ICountGuestForWorkerDataSource>(),
  ));
  getIt.registerSingleton<IDoneInOrOutGuestRepository>(
    DoneInOrOutGuestRepositoryImp(
      getIt<IDoneInOrOutGuestDataSource>(),
    ),
  );
  getIt.registerSingleton<IGetAllGuestRepository>(
    GetAllGuestRepositoryImp(
      getIt<IGetAllGuestDataSource>(),
    ),
  );
  getIt.registerSingleton<IGetGuestForObjectIdRepository>(
    GetGuestForObjectIdRepositoryImp(
      getIt<IGetGuestDataSource>(),
    ),
  );
  getIt.registerSingleton<ISaveGuestRepository>(
    SaveGuestRepositoryImp(
      getIt<ISaveGuestDataSource>(),
    ),
  );
  getIt.registerSingleton<ISearchGuestForContactRepository>(
    SearchGuestForContactRepositoryImp(
        getIt<ISearchGuestForContactDataSource>()),
  );
  //####### - Event - REPOSITORY

  getIt.registerSingleton<IGetAllEventRepository>(
    GetAllEventRepositoryImp(getIt<IGetAllEventDataSource>()),
  );
  getIt.registerSingleton<ISaveEventRepository>(
    SaveEventRepositoryImp(getIt<ISaveEventDataSource>()),
  );

  //####### - Worker - REPOSITORY
  getIt.registerSingleton<IAddWorkerEventRepository>(
      AddWorkerEventRepositoryImp(getIt<IAddWorkerEventDataSource>()));
  getIt.registerSingleton<ICreateWorkerRepository>(
      CreateWorkerRepositoryImp(getIt<ICreateWorkerDataSource>()));
  getIt.registerSingleton<IGetAllWorkerRepository>(
      GetAllWorkerRepositoryImp(getIt<IGetAllWorkerDataSource>()));
  getIt.registerSingleton<IGetAllWorkerInEventRepository>(
      GetAllWorkerInEventRepositoryImp(
          getIt<IGetAllWorkerInEventDataSource>()));
  getIt.registerSingleton<IWorkerLoginRepository>(
      WorkerLoginRepositoryImp(getIt<IWorkerLoginDataSource>()));
  getIt.registerSingleton<IRemoveWorkerEventRepository>(
      RemoveWorkerEventRepositoryImp(getIt<IRemoveWorkerEventDataSource>()));
  getIt.registerSingleton<IVerifyWorkerEventRepository>(
      VerifyWorkerEventRepositoryImp(getIt<IVerifyWorkerEventDataSource>()));

  //###### - Manager - REPOSITORY
  getIt.registerSingleton<ILoginManagerRepository>(
      LoginManagerRepositoryImp(getIt<ILoginManagerDataSource>()));

  getIt.registerSingleton<ICreateManagerRepository>(
      CreateManagerRepositoryImp(getIt<ICreateManagerDataSource>()));

  //######## - Product - REPOSITORY

  getIt.registerSingleton<ISaveProductRepository>(
    SaveProductRepositoryImp(
      getIt<ISaveProductDataSource>(),
    ),
  );

  getIt.registerSingleton<IGetAllProductRepository>(
      GetAllProductRepositoryImp(getIt<IGetAllProductDataSource>()));

  // ##### - Credit - REPOSITORY
  getIt.registerSingleton<IMakeCreditRepository>(MakeCreditRepositoryImp(
    getIt<IMakeCreditDataSource>(),
  ));

  //####### - Sale - REPOSITORY
  getIt.registerSingleton<IMakeSaleRepository>(MakeSaleRepositoryImp(
    getIt<IMakeSaleDataSource>(),
  ));

  //###### - Report - REPOSITORY
  getIt.registerSingleton<IGetAllCreditForEventRepository>(
      GetAllCreditForEventRepositoryImp(
          getIt<IGetAllCreditForEventDataSource>()));

  getIt.registerSingleton<IGetAllSaleForEventRepository>(
      GetAllSaleForEventRepositoryImp(getIt<IGetAllSaleForEventDataSource>()));

  //USECASE
  //####### - Guest - USECASE
  getIt.registerSingleton<ICountGuestForEventUseCase>(
    CountGuestForEventUseCaseImp(
      getIt<ICountGuestForEventRepository>(),
    ),
  );
  getIt.registerSingleton<ICountGuestForWorkerUseCase>(
      CountGuestForWorkerUseCaseImp(getIt<ICountGuestForWorkerRepository>()));
  getIt.registerSingleton<IDoneInOrOutGuestUseCase>(
    DoneInOrOutGuestUseCaseImp(getIt<IDoneInOrOutGuestRepository>()),
  );
  getIt.registerSingleton<IGetAllGuestUseCase>(
    GetAllGuestUseCaseImp(getIt<IGetAllGuestRepository>()),
  );
  getIt.registerSingleton<IGetGuestForObjectIdUseCase>(
    GetGuestForObjectIdUseCaseImp(getIt<IGetGuestForObjectIdRepository>()),
  );
  getIt.registerSingleton<ISaveGuestUseCase>(
    SaveGuestUseCaseImp(getIt<ISaveGuestRepository>()),
  );
  getIt.registerSingleton<ISearchGuestForContactUseCase>(
    SearchGuestForContactUseCaseImp(getIt<ISearchGuestForContactRepository>()),
  );
  //####### - Event - USECASE
  getIt.registerSingleton<IGetAllEventUseCase>(
    GetAllEventUseCaseImp(getIt<IGetAllEventRepository>()),
  );
  getIt.registerSingleton<ISaveEventUseCase>(
    SaveEventUseCaseImp(getIt<ISaveEventRepository>()),
  );
  //####### - Worker - USECASE
  getIt.registerSingleton<IAddWorkerEventUseCase>(
      AddWorkerEventUseCaseImp(getIt<IAddWorkerEventRepository>()));
  getIt.registerSingleton<ICreateWorkerUseCase>(
      CreateWorkerUseCaseImp(getIt<ICreateWorkerRepository>()));
  getIt.registerSingleton<IGetAllWorkerUseCase>(
      GetAllWorkerUseCaseImp(getIt<IGetAllWorkerRepository>()));
  getIt.registerSingleton<IGetAllWorkerInEventUseCase>(
      GetAllWorkerInEventUseCaseImp(getIt<IGetAllWorkerInEventRepository>()));
  getIt.registerSingleton<ILoginWorkerUseCase>(
    LoginWorkerUseCaseImp(getIt<IWorkerLoginRepository>()),
  );
  getIt.registerSingleton<IRemoveWorkerEventUseCase>(
      RemoveWorkerEventUseCaseImp(getIt<IRemoveWorkerEventRepository>()));
  getIt.registerSingleton<IVerifyWorkerEventUseCase>(
      VerifyWorkerEventUseCaseImp(getIt<IVerifyWorkerEventRepository>()));

  //###### - Manager - USECASE
  getIt.registerSingleton<ILoginManagerUseCase>(
      LoginManagerUseCaseImp(getIt<ILoginManagerRepository>()));

  getIt.registerSingleton<ICreateManagerUseCase>(
      CreateManagerUseCaseImp(getIt<ICreateManagerRepository>()));
  //###### - Product - USECASE
  getIt.registerSingleton<ISaveProductUseCase>(
      SaveProductUseCaseImp(getIt<ISaveProductRepository>()));
  getIt.registerSingleton<IGetAllProductUseCase>(
    GetAllProductUseCaseImp(
      getIt<IGetAllProductRepository>(),
    ),
  );

  //###### - Credit - USECASE
  getIt.registerSingleton<IMakeCreditUseCase>(MakeCreditUseCaseImp(
    getIt<IMakeCreditRepository>(),
  ));
  //###### - Sale - USECASE
  getIt.registerSingleton<IMakeSaleUseCase>(MakeSaleUseCaseImp(
    getIt<IMakeSaleRepository>(),
  ));
  //###### - Report - USECASE

  getIt.registerSingleton<IGetAllCreditForEventUseCase>(
      GetAllCreditForEventUseCaseImp(getIt<IGetAllCreditForEventRepository>()));

  getIt.registerSingleton<IGetAllSaleForEventUseCase>(
      GetAllSaleForEventUseCaseImp(getIt<IGetAllSaleForEventRepository>()));

  //CONTROLLER
  getIt.registerSingleton<AddEventController>(AddEventController());
  getIt.registerSingleton<AddGuestController>(AddGuestController());
  getIt.registerSingleton<LoginController>(LoginController(
      getIt<ILoginManagerUseCase>(), getIt<ILoginWorkerUseCase>()));
  getIt.registerSingleton<ManagerEventController>(
      ManagerEventController(getIt<IGetAllEventUseCase>()));

  getIt.registerSingleton<ManagerWorkerController>(
    ManagerWorkerController(
      getIt<IGetAllWorkerUseCase>(),
      getIt<IVerifyWorkerEventUseCase>(),
      getIt<IAddWorkerEventUseCase>(),
      getIt<IRemoveWorkerEventUseCase>(),
    ),
  );

  getIt.registerSingleton<RegisterInOrOutGuestController>(
      RegisterInOrOutGuestController(
          getIt<ISaveGuestUseCase>(), getIt<IGetGuestForObjectIdUseCase>()));

  getIt.registerSingleton<CreateWorkerController>(
      CreateWorkerController(getIt<ICreateWorkerUseCase>()));
  getIt.registerSingleton<CreateManagerController>(
      CreateManagerController(getIt<ICreateManagerUseCase>()));
  getIt.registerSingleton<ReportEventController>(
    ReportEventController(
        getIt<IGetAllWorkerInEventUseCase>(),
        getIt<ICountGuestForEventUseCase>(),
        getIt<ICountGuestForWorkerUseCase>(),
        getIt<IGetAllCreditForEventUseCase>(),
        getIt<IGetAllSaleForEventUseCase>()),
  );
  getIt.registerSingleton<SearchGuestController>(
      SearchGuestController(getIt<ISearchGuestForContactUseCase>()));

  getIt.registerSingleton<CreateProductController>(CreateProductController(
      getIt<IGetAllProductUseCase>(), getIt<ISaveProductUseCase>()));

  getIt.registerSingleton<MakeCreditController>(MakeCreditController(
      getIt<IGetGuestForObjectIdUseCase>(), getIt<IMakeCreditUseCase>()));

  getIt.registerSingleton<MakeSaleController>(MakeSaleController(
      getIt<IMakeSaleUseCase>(), getIt<IGetGuestForObjectIdUseCase>()));
}
