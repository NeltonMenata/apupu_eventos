class WorkerEntity {
  final String username;
  final String password;
  final String name;
  final String? objectId;
  final String? managerObjectId;
  final bool? isBlocked;
  final bool isDoorman;
  final String? error;

  WorkerEntity(
      {required this.username,
      required this.password,
      required this.name,
      this.objectId,
      this.isBlocked,
      this.error,
      this.managerObjectId,
      required this.isDoorman});
}
