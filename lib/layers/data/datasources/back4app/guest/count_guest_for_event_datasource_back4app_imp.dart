import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../guest/count_guest_for_event_datasource.dart';

class CountGuestForEventDataSourceBack4appImp
    implements ICountGuestForEventDataSource {
  @override
  Future<int> call(String eventObjectId) async {
    try {
      final countGuestEvent = ParseCloudFunction("countGuestForEvent");

      final result = await countGuestEvent
          .execute(parameters: {"eventObjectId": eventObjectId});

      return result.result;
    } catch (e) {
      return 0;
    }
  }
}
