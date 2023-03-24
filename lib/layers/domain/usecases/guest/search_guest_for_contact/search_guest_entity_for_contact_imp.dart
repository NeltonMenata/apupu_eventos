import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import '../../../repositories/search_guest_for_contact/get_guest_for_objectId_repository.dart';
import 'search_guest_entity_for_contact.dart';

class SearchGuestForContactUseCaseImp implements ISearchGuestForContactUseCase {
  final ISearchGuestForContactRepository _searchGuestForContactRepository;
  SearchGuestForContactUseCaseImp(this._searchGuestForContactRepository);

  @override
  Future<List<GuestEntity>> call(String contact, String eventObjectId) async {
    return await _searchGuestForContactRepository(contact, eventObjectId);
  }
}
