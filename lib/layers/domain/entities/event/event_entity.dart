class EventEntity {
  final String objectId;
  final String name;
  final DateTime dateOfRealization;
  final String organization;
  final String imgCatalog;
  final double price;

  EventEntity({
    required this.objectId,
    required this.name,
    required this.dateOfRealization,
    required this.organization,
    required this.imgCatalog,
    required this.price,
  });
}
