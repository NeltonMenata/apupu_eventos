import 'package:apupu_eventos/layers/data/datasources/guest/search_guest_for_contact_datasource.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../../../domain/entities/guest/guest_entity.dart';

class SearchGuestForContactDataSourceBack4appImp
    implements ISearchGuestForContactDataSource {
  @override
  Future<List<GuestEntity>> call(String contact, String eventObjectId) async {
    final searchGuestFunction = ParseCloudFunction("searchGuestForContact");

    final resultSearch = await searchGuestFunction.execute(
        parameters: {"contact": contact, "eventObjectId": eventObjectId});
    if (resultSearch.statusCode == 200) {
      final List<GuestEntity> list = [];
      resultSearch.result.forEach((e) {
        list.add(
          GuestEntity(
            objectId: e["objectId"],
            name: e["name"],
            workerObjectId: e["workerObjectId"],
            eventObjectId: e["eventObjectId"],
            contact: e["contact"],
            isIn: e["isIn"],
          ),
        );
      });

      return list;
    }
    return [];
  }
}
