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
      this.error});
}
