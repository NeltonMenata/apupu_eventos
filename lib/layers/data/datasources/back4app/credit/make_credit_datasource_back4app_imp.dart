import 'package:apupu_eventos/layers/data/datasources/credit/make_credit_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/credit/credit_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class MakeCreditDataSourceBack4appImp implements IMakeCreditDataSource {
  @override
  Future<CreditEntity> call(CreditEntity credit) async {
    try {
      final creditFun =
          await ParseCloudFunction("makeCredit").execute(parameters: {
        "credit": credit.credit,
        "eventObjectId": credit.eventObjectId,
        "guestObjectId": credit.guestObjectId,
        "workerObjectId": credit.workerObjectId,
      });
      if (creditFun.statusCode == 200) {
        if (creditFun.result["error"] != null) {
          return CreditEntity(
              credit: 0,
              eventObjectId: "eventObjectId",
              workerObjectId: "workerObjectId",
              guestObjectId: "guestObjectId",
              error: creditFun.result["error"]);
        } else {
          return CreditEntity(
            credit: creditFun.result["credit"],
            eventObjectId: credit.eventObjectId,
            workerObjectId: credit.workerObjectId,
            guestObjectId: credit.guestObjectId,
          );
        }
      } else {
        return CreditEntity(
            credit: 0,
            eventObjectId: "eventObjectId",
            workerObjectId: "workerObjectId",
            guestObjectId: "guestObjectId",
            error: creditFun.error?.message);
      }
    } catch (e) {
      return CreditEntity(
          credit: 0,
          eventObjectId: "eventObjectId",
          workerObjectId: "workerObjectId",
          guestObjectId: "guestObjectId",
          error: e.toString());
    }
  }
}
