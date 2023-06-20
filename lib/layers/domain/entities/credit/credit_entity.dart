class CreditEntity {
  final String? objectId;
  final int credit;
  final String eventObjectId;
  final String? workerObjectId;
  final String guestObjectId;
  final String? error;

  CreditEntity(
      {this.objectId,
      required this.credit,
      this.error,
      required this.eventObjectId,
      this.workerObjectId,
      required this.guestObjectId});
}
