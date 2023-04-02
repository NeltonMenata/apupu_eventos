import 'package:apupu_eventos/layers/domain/usecases/guest/get_all_guest/get_all_guest_entity_usecase.dart';

import '../../../entities/guest/guest_entity.dart';
import '../../../repositories/guest/get_all_guest_repository/get_all_event_repository.dart';

class GetAllGuestUseCaseImp implements IGetAllGuestUseCase {
  final IGetAllGuestRepository _getAllGuestReposity;
  GetAllGuestUseCaseImp(this._getAllGuestReposity);
  @override
  Future<List<GuestEntity>> call() async {
    return await _getAllGuestReposity();
  }
}
