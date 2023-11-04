class ProductEntity {
  final String? objectId;
  final String? name;
  final int price;
  final int? quantity;
  final String eventObjectId;
  final String? error;
  bool? favorite;

  ProductEntity(
      {this.objectId,
      this.name,
      required this.price,
      required this.eventObjectId,
      this.quantity,
      this.favorite,
      this.error});

  int get totalValue => price * (quantity ?? 1);
}
