class WorkerEntity {
  final String username;
  final String password;
  final String name;
  final String? objectId;
  final String? managerObjectId;
  final bool? isBlocked;
  final bool isDoorman;
  final String? phone;
  final String? error;

  WorkerEntity(
      {required this.username,
      required this.password,
      required this.name,
      this.objectId,
      this.isBlocked,
      this.error,
      this.managerObjectId,
      this.phone,
      required this.isDoorman});

  @override
  String toString() {
    super.toString();

    return "username: $username, password: $password, name: $name, error: $error";
  }
}
