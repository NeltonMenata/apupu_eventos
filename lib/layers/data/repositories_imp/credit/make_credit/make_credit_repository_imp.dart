import 'package:apupu_eventos/layers/data/datasources/credit/make_credit_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/credit/credit_entity.dart';
import 'package:apupu_eventos/layers/domain/repositories/credit/make_credit/make_credit_repository.dart';

class MakeCreditRepositoryImp implements IMakeCreditRepository {
  final IMakeCreditDataSource _makeCreditDataSource;

  MakeCreditRepositoryImp(this._makeCreditDataSource);
  @override
  Future<CreditEntity> call(CreditEntity credit) async {
    return await _makeCreditDataSource(credit);
  }
}
