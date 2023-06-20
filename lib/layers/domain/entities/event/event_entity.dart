class EventEntity {
  final String objectId;
  final String? managerObjectId;
  final String name;
  final DateTime dateOfRealization;
  final String organization;
  String? imgCartaz;
  final int price;
  final int? priceVip;

  EventEntity(
      {required this.objectId,
      required this.name,
      this.managerObjectId,
      required this.dateOfRealization,
      required this.organization,
      this.imgCartaz,
      required this.price,
      this.priceVip});
}
