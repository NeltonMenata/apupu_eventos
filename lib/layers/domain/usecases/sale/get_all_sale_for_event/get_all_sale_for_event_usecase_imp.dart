import 'package:apupu_eventos/layers/domain/entities/report_sale/report_sale_entity.dart';
import 'package:apupu_eventos/layers/domain/repositories/sale/get_all_sale_for_event/get_all_sale_for_event_repository.dart';
import 'package:apupu_eventos/layers/domain/usecases/sale/get_all_sale_for_event/get_all_sale_for_event_usecase.dart';

class GetAllSaleForEventUseCaseImp implements IGetAllSaleForEventUseCase {
  final IGetAllSaleForEventRepository _getAllSaleForEventRepository;

  GetAllSaleForEventUseCaseImp(this._getAllSaleForEventRepository);
  @override
  Future<List<ReportSaleEntity>> call(String eventObjectId) async {
    return await _getAllSaleForEventRepository(eventObjectId);
  }
}
