class GuestEntity {
  final String objectId;
  final String name;
  final String contact;
  bool isIn;
  final int? credit;
  final bool isVip;
  final String eventObjectId;
  final String? workerObjectId;
  final String? error;

  GuestEntity({
    required this.objectId,
    required this.name,
    required this.contact,
    this.credit,
    this.isIn = false,
    this.isVip = false,
    required this.workerObjectId,
    required this.eventObjectId,
    this.error,
  });
}
