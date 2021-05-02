import 'package:malsat_app/models/user.dart';

import 'category.dart';
import 'city.dart';

class Posts {
  Posts({
    this.id,
    this.title,
    this.user,
    this.city,
    this.description,
    this.price,
    this.exchange,
    this.auction,
    this.delivery,
    this.category,
    this.gender,
  });

  int id;
  String title;
  User user;
  City city;
  String description;
  String price;
  bool exchange;
  bool auction;
  bool delivery;
  Category category;
  String gender;
}