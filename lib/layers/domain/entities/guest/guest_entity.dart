class GuestEntity {
  final String objectId;
  final String name;
  final String contact;
  bool isIn;
  final String eventObjectId;
  final String? workerObjectId;

  GuestEntity({
    required this.objectId,
    required this.name,
    required this.contact,
    this.isIn = false,
    required this.workerObjectId,
    required this.eventObjectId,
  });
}
