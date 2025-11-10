class CommissionModel {
  final String? type;
  final num? amount;
  final num? subscriptionAmount;
  final String? planId;
  final String? referredUserFullName;
  final String? referredUserAvatar;
  final DateTime? date;
  final String? status;
  final String? paymentMethod;

  CommissionModel({
    required this.type,
    required this.amount,
    required this.subscriptionAmount,
    required this.planId,
    required this.referredUserFullName,
    required this.referredUserAvatar,
    required this.date,
    required this.status,
    required this.paymentMethod,
  });

  factory CommissionModel.fromJson(Map<String, dynamic> json) {
    return CommissionModel(
      type: json["type"] ?? "commission",
      amount: num.tryParse(json["amount"].toString()) ?? 0,
      subscriptionAmount:
          num.tryParse(json["subscriptionAmount"].toString()) ?? 0,
      planId: json["planId"] ?? "",
      referredUserFullName: json["referredUserFullName"] ?? "",
      referredUserAvatar: json["referredUserAvatar"] ?? "",
      date: json["date"] != null
          ? DateTime.tryParse(json["date"].toString())
          : DateTime.now(),
      status: "paid",
      paymentMethod: "Funded",
    );
  }
}
