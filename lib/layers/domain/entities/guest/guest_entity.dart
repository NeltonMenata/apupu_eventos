class GuestEntity {
  final String objectId;
  final String name;
  final String contact;
  final bool isIn;
  final String eventObjectId;

  GuestEntity({
    required this.objectId,
    required this.name,
    required this.contact,
    this.isIn = false,
    required this.eventObjectId,
  });
}
