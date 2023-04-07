import 'package:apupu_eventos/layers/domain/repositories/guest/count_guest_for_event/count_guest_for_event_repository.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/count_guest_for_event/count_guest_for_event_usecase.dart';

class CountGuestForEventUseCaseImp implements ICountGuestForEventUseCase {
  final ICountGuestForEventRepository _countGuestForEventRepository;
  CountGuestForEventUseCaseImp(this._countGuestForEventRepository);
  @override
  Future<int> call(String eventObjectId) async {
    return await _countGuestForEventRepository(eventObjectId);
  }
}
