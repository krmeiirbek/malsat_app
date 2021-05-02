import 'package:malsat_app/models/city.dart';

class User {
  int id;
  String email;
  String firstName;
  String image;
  String phone;
  City city;
  DateTime dateJoined;

  User({
    this.id,
    this.email,
    this.firstName,
    this.image,
    this.phone,
    this.city,
    this.dateJoined,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      email: json["email"],
      firstName: json["first_name"],
      image: json["image"],
      phone: json["phone"],
      city: json["cities"],
      dateJoined: json["dateJoined"],
    );
  }
}
