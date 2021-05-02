import 'package:malsat_app/models/city.dart';

class User {
  int id;
  String email;
  String firstName;
  String image;
  String phone;
  City city;

  User({
    this.id,
    this.email,
    this.firstName,
    this.image,
    this.phone,
    this.city,
  });

}
