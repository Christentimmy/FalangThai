class WithdrawModel {
  final String? id;
  final num? amount;
  final String? status;
  final String? paymentMethod;
  final DateTime? date;
  final String? type;

  WithdrawModel({
    required this.id,
    required this.amount,
    required this.status,
    required this.paymentMethod,
    required this.date,
    required this.type,
  });

  factory WithdrawModel.fromJson(Map<String, dynamic> json) {
    return WithdrawModel(
      id: json["id"] ?? "",
      amount: num.tryParse(json["amount"]) ?? 0,
      status: json["status"] ?? "",
      paymentMethod: json["paymentMethod"] ?? "",
      date: json["date"] != null
          ? DateTime.tryParse(json["date"]) ?? DateTime.now()
          : DateTime.now(),
      type: json["type"] ?? "withdrawal",
    );
  }
}
