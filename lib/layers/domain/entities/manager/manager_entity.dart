class ManagerEntity {
  final String username;
  final String? password;
  final String name;
  final String? objectId;
  final bool? isBlocked;
  final bool? isAdmin;
  final String? investor;
  final String? phone;
  final String? uid;
  final String? error;

  ManagerEntity(
      {required this.username,
      this.password,
      required this.name,
      this.objectId,
      this.isBlocked,
      this.isAdmin,
      this.error,
      this.phone,
      this.uid,
      this.investor});
}
