import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';

abstract class IGetAllGuestUseCase {
  Future<List<GuestEntity>> call();
}
