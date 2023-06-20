import 'package:apupu_eventos/layers/data/datasources/credit/get_all_credit_for_event_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/report_credit/report_credit_entity.dart';
import 'package:apupu_eventos/layers/domain/repositories/credit/get_all_credit_for_event/get_all_credit_for_event_repository.dart';

class GetAllCreditForEventRepositoryImp
    implements IGetAllCreditForEventRepository {
  final IGetAllCreditForEventDataSource _getAllCreditForEventDataSource;

  GetAllCreditForEventRepositoryImp(this._getAllCreditForEventDataSource);

  @override
  Future<List<ReportCreditEntity>> call(String eventObjectId) async {
    return await _getAllCreditForEventDataSource(eventObjectId);
  }
}
