class UserModel {
  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.role,
  });

  String email;
  String name;
  String phone;
  String role;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "phone": phone,
        "role": role,
      };
}
