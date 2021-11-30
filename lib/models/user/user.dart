class User {
  String? fullName;
  String? email;
  String? gender;
  String? phone;
  String? picture;

  User({
    this.fullName,
    this.email,
    this.gender,
    this.phone,
    this.picture,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        fullName: json["fullName"],
        email: json["email"],
        gender: json["gender"],
        phone: json["phone"],
        picture: json["picture"],
      );

  Map<String, dynamic> toMap() => {
        "fullName": fullName,
        "email": email,
        "gender": gender,
        "phone": phone,
        "picture": picture,
      };
}
