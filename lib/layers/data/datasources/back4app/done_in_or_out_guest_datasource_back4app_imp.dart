import 'package:apupu_eventos/layers/data/datasources/done_in_or_out_guest_datasource.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class DoneInOrOutGuestDatasourceBack4appImp
    implements IDoneInOrOutGuestDataSource {
  @override
  Future<bool> call(String objectId, bool inOrOut) async {
    try {
      final getOneGuest = ParseCloudFunction("doneInOrOutGuest");

      final result = await getOneGuest
          .execute(parameters: {"objectId": objectId, "inOrOut": inOrOut});

      print(result.result);
      return result.result["inOrOut"];
    } catch (e) {
      return false;
    }
  }
}
