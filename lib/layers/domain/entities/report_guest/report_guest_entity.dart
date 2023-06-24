class ReportGuestEntity {
  final String workerName;
  final int normal;
  final int vip;
  final String? error;

  ReportGuestEntity(
      {required this.normal,
      required this.vip,
      required this.workerName,
      this.error});
}
