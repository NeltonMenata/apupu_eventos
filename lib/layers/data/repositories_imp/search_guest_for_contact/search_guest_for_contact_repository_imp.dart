import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:apupu_eventos/layers/domain/repositories/search_guest_for_contact/get_guest_for_objectId_repository.dart';
import '../../datasources/search_guest_for_contact_datasource.dart';

class SearchGuestForContactRepositoryImp
    implements ISearchGuestForContactRepository {
  final ISearchGuestForContactDataSource _searchGuestForContactDataSource;

  SearchGuestForContactRepositoryImp(this._searchGuestForContactDataSource);

  @override
  Future<List<GuestEntity>> call(String contact, String eventObjectId) {
    return _searchGuestForContactDataSource(contact, eventObjectId);
  }
}
