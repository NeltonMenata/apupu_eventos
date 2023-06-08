import 'package:apupu_eventos/layers/domain/entities/credit/credit_entity.dart';
import 'package:apupu_eventos/layers/domain/repositories/credit/make_credit/make_credit_repository.dart';
import 'package:apupu_eventos/layers/domain/usecases/credit/make_credit/make_credit_usecase.dart';

class MakeCreditUseCaseImp implements IMakeCreditUseCase {
  final IMakeCreditRepository _makeCreditRepository;

  MakeCreditUseCaseImp(this._makeCreditRepository);

  @override
  Future<CreditEntity> call(CreditEntity credit) async {
    return await _makeCreditRepository(credit);
  }
}
