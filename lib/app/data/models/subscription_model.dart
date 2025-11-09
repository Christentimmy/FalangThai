class SubscriptionModel {
  String? id;
  String? name;
  String? billingCycle;
  String? price;
  List? features;

  SubscriptionModel({
    this.id,
    this.name,
    this.billingCycle,
    this.price,
    this.features,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      billingCycle: json["billingCycle"] ?? "",
      price: json["price"].toString(),
      features: json["features"]?.map((e) => e.toString()).toList() ?? [],
    );
  }
}
