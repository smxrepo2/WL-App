import 'dart:convert';

Grocery groceryFromJson(String str) => Grocery.fromJson(json.decode(str));

String groceryToJson(Grocery data) => json.encode(data.toJson());

class Grocery {
  Grocery({
    this.grocery,
    this.planId,
  });

  String grocery;
  int planId;

  factory Grocery.fromJson(Map<String, dynamic> json) => Grocery(
    grocery: json["Grocery"],
    planId: json["PlanId"],
  );

  Map<String, dynamic> toJson() => {
    "Grocery": grocery,
    "PlanId": planId,
  };
}