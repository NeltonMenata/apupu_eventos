import 'package:apupu_eventos/layers/domain/entities/product/product_entity.dart';

class SaleEntity {
  final String objectId;
  final ProductEntity product;
  final int quantity;

  SaleEntity(this.objectId, this.product, this.quantity);

  int get getTotalValueForSale => product.price * quantity;
}
