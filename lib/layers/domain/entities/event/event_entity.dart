class EventEntity {
  final String objectId;
  final String? managerObjectId;
  final String name;
  final DateTime dateOfRealization;
  final String organization;
  String? imgCartaz;
  final int price;
  final int? priceVip;
  final int? bonusCredit;
  final String? error;
  final bool? payment;
  final int? productsQuantity;
  final int? productsValue;
  final int? vip;
  final int? normal;

  EventEntity(
      {required this.objectId,
      required this.name,
      this.managerObjectId,
      required this.dateOfRealization,
      required this.organization,
      this.imgCartaz,
      required this.price,
      this.priceVip,
      this.bonusCredit,
      this.payment,
      this.productsQuantity,
      this.productsValue,
      this.vip,
      this.normal,
      this.error});
}
