class ReportSaleEntity {
  final String name;
  final int quantity;
  final int totalValue;
  final String? error;

  ReportSaleEntity(
      {required this.name,
      required this.quantity,
      required this.totalValue,
      this.error});
}
