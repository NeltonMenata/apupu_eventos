import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/get_guest_for_objectId_usecase/get_guest_entity_for_objectId.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/save_guest/save_guest_usecase.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class RegisterInOrOutGuestController {
  final ISaveGuestUseCase _saveGuest;
  final IGetGuestForObjectIdUseCase _getGuestForObjectIdUseCase;

  RegisterInOrOutGuestController(
      this._saveGuest, this._getGuestForObjectIdUseCase);

  Future<GuestEntity> saveGuest(GuestEntity _guestEntity) async {
    return await _saveGuest(_guestEntity);
  }

  Future<GuestEntity> getGuest(String eventObjectId) async {
    var qrResult = await FlutterBarcodeScanner.scanBarcode(
        "red", "Cancelar", true, ScanMode.QR);

    return await _getGuestForObjectIdUseCase(qrResult, eventObjectId);
  }
}
