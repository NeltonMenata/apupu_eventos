import '../../../domain/entities/guest/guest_entity.dart';
import '../../../domain/usecases/guest/search_guest_for_contact/search_guest_entity_for_contact.dart';

class SearchGuestController {
  SearchGuestController(this._searchGuestUseCase);
  final List<GuestEntity> _listGuest = [];

  List<GuestEntity> get listGuest => _listGuest;

  final ISearchGuestForContactUseCase _searchGuestUseCase;
/*
  Future<List<GuestEntity>> listGuest() async {
    final listSearch = await _listGuest();
    final reversedList = listSearch.reversed.toList();
    return reversedList;
  }
  */

  Future<void> findGuest(String contact, String eventObjectId) async {
    cleanListGuest();
    final listSearch = await _searchGuestUseCase(contact, eventObjectId);
    _listGuest.addAll(listSearch);
  }

  cleanListGuest() {
    _listGuest.clear();
  }
}
