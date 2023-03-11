import 'package:apupu_eventos/layers/data/datasources/mock/get_all_guest_datasource_mock_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/get_all_guest/get_all_event_repository_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/get_all_guest/get_all_guest_entity_usecase_imp.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/guest/guest_entity.dart';

class SearchGuestController {
  static final controller = SearchGuestController();
  final scrollController = ScrollController();
  final _listGuest = GetAllGuestUseCaseImp(
    GetAllGuestRepositoryImp(
      GetAllGuestDataSourceMockImp(),
    ),
  );

  Future<List<GuestEntity>> listGuest() async {
    final listSearch = await _listGuest();
    final reversedList = listSearch.reversed.toList();
    return reversedList;
  }

  Future<List<GuestEntity>> findGuest(String contact) async {
    final listSearch = await _listGuest();

    final reversedList =
        listSearch.where((element) => element.contact == contact).toList();
    return reversedList.reversed.toList();
  }
}
