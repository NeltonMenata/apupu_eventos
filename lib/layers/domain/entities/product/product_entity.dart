class ProductEntity {
  final String? objectId;
  final String name;
  final int price;
  final String eventObjectId;
  final String? error;

  ProductEntity(this.objectId, this.name, this.price, this.eventObjectId,
      [this.error]);
}
