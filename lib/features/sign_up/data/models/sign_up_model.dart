class UserSignUpModel {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String image;

  UserSignUpModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "email": email,
      "password": password,
      "image": image,
    };
  }
}
