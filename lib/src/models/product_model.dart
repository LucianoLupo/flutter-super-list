class ProductModel {
  ProductModel({
    this.id,
    this.uuid,
    this.expectedQuantity,
    this.purchasedQuantity,
    this.name,
    this.description,
  });

  int id;
  String uuid;
  int expectedQuantity;
  int purchasedQuantity;
  String name;
  String description;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        uuid: json["uuid"],
        expectedQuantity: json["expected_quantity"],
        purchasedQuantity: json["purchased_quantity"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "expected_quantity": expectedQuantity,
        "purchased_quantity": purchasedQuantity,
        "name": name,
        "description": description,
      };
}
