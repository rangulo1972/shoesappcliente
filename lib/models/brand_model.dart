class BrandModel {
  String? id;
  String name;
  bool status;
  String image;

  BrandModel({
    this.id,
    required this.name,
    required this.status,
    required this.image,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        id: json["id"] ?? "None",
        name: json["name"] ?? "None",
        status: json["status"] ?? false,
        image: json["image"] ?? "None",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "image": image,
      };
}
