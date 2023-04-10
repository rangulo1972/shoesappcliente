class ProductModel {
  String name;
  double price;
  String image;
  int discount;
  String brand;
  bool status;
  int stock;
  List<double> sizes;

  ProductModel({
    required this.name,
    required this.price,
    required this.image,
    required this.discount,
    required this.brand,
    required this.status,
    required this.stock,
    required this.sizes,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        name: json["name"] ?? "None",
        price: json["price"] != null ? json["price"].toDouble() : 0,
        discount: json["discount"] ?? 0,
        image: json["image"] ?? "",
        status: json["status"] ?? false,
        stock: json["stock"] ?? 0,
        brand: json["brand"] ?? "",
        sizes: json["size"] != null
            ? List<double>.from(json["size"].map((e) => e.toDouble()))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "discount": discount,
        "image": image,
        "status": status,
        "stock": stock,
        "brand": brand,
        "sizes": List<dynamic>.from(sizes.map((e) => e)),
      };
}
