import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/done_in_or_out_guest/done_in_or_out_guest.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/get_guest_for_objectId_usecase/get_guest_entity_for_objectId.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/save_guest/save_guest_usecase.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class RegisterInOrOutGuestController {
  final ISaveGuestUseCase _saveGuest;
  final IGetGuestForObjectIdUseCase _getGuestForObjectIdUseCase;
  final IDoneInOrOutGuestUseCase _doneInOrOutGuestUseCase;
  RegisterInOrOutGuestController(this._saveGuest,
      this._getGuestForObjectIdUseCase, this._doneInOrOutGuestUseCase);

  Future<GuestEntity> saveGuest(GuestEntity _guestEntity) async {
    return await _saveGuest(_guestEntity);
  }

  Future<GuestEntity> getGuest(String eventObjectId) async {
    var qrResult = await FlutterBarcodeScanner.scanBarcode(
        "red", "Cancelar", true, ScanMode.QR);
    if (qrResult == "-1") {}
    return await _getGuestForObjectIdUseCase(qrResult, eventObjectId);
  }

  Future<bool> doneInOrOutGuest(String objectId, bool inOrOut) async {
    return await _doneInOrOutGuestUseCase(objectId, inOrOut);
  }
}
