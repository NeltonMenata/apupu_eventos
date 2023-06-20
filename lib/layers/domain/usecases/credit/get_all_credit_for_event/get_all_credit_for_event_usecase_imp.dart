import 'package:apupu_eventos/layers/domain/entities/report_credit/report_credit_entity.dart';
import 'package:apupu_eventos/layers/domain/repositories/credit/get_all_credit_for_event/get_all_credit_for_event_repository.dart';
import 'package:apupu_eventos/layers/domain/usecases/credit/get_all_credit_for_event/get_all_credit_for_event_usecase.dart';

class GetAllCreditForEventUseCaseImp implements IGetAllCreditForEventUseCase {
  final IGetAllCreditForEventRepository _getAllCreditForEventRepository;

  GetAllCreditForEventUseCaseImp(this._getAllCreditForEventRepository);

  @override
  Future<List<ReportCreditEntity>> call(String eventObjectId) async {
    return await _getAllCreditForEventRepository(eventObjectId);
  }
}
