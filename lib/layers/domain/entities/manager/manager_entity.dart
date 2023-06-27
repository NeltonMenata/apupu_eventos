class ManagerEntity {
  final String username;
  final String? password;
  final String name;
  final String? objectId;
  final bool? isBlocked;
  final String? investor;
  final String? phone;
  final String? error;

  ManagerEntity(
      {required this.username,
      this.password,
      required this.name,
      this.objectId,
      this.isBlocked,
      this.error,
      this.phone,
      this.investor});
}
