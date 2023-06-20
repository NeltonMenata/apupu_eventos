import 'package:apupu_eventos/layers/domain/entities/product/product_entity.dart';

class SaleEntity {
  final String? objectId;
  final List<ProductEntity> products;
  final String eventObjectId;
  final String? workerObjectId;
  final String guestObjectId;
  final String? error;

  SaleEntity(
      {this.objectId,
      required this.products,
      required this.eventObjectId,
      this.workerObjectId,
      required this.guestObjectId,
      this.error});

  int get getTotalValueForSale {
    int totalValueSale = 0;
    final totalValues = products.map((product) => product.totalValue).toList();
    for (var value in totalValues) {
      totalValueSale += value;
    }
    return totalValueSale;
  }
}
