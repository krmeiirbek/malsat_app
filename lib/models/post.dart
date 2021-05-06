import 'package:intl/intl.dart';
import 'package:malsat_app/models/user.dart';
import 'category.dart';
import 'city.dart';

class Post {
  Post({
    this.id,
    this.title,
    this.user,
    this.cities,
    this.description,
    this.price,
    this.exchange,
    this.auction,
    this.delivery,
    this.categories,
    this.date,
    this.images,
    this.bookmarks,
    this.isApproved,
    this.views,
    this.phoneViews,
    this.postViews,
    this.bookmarkViews,
    this.isHidden,
  });

  int id;
  String title;
  User user;
  City cities;
  String description;
  String price;
  bool exchange;
  bool auction;
  bool delivery;
  Category categories;
  DateTime date;
  List<dynamic> images;
  List<dynamic> bookmarks;
  bool isApproved;
  int views;
  List<dynamic> phoneViews;
  List<dynamic> postViews;
  List<dynamic> bookmarkViews;
  bool isHidden;

  factory Post.fromJson(Map<String, dynamic> json) {
    User user = User.fromJson(json['user']);
    City city = City.fromJson(json['cities']);
    Category category = Category.fromJson(json['categories']);
    return Post(
      id: json["id"],
      title: json["title"],
      user: user,
      cities: city,
      description: json["description"],
      price: json["price"],
      exchange: json["exchange"],
      auction: json["auction"],
      delivery: json["delivery"],
      categories: category,
      date:  DateFormat("yyyy-MM-dd").parse(json["date"]) ,
      images: json["images"],
      bookmarks: json["bookmarks"],
      isApproved: json["isApproved"],
      views: json["views"],
      phoneViews: json["phone_views"],
      postViews: json["post_views"],
      bookmarkViews: json["bookmark_views"],
      isHidden: json["isHidden"],
    );
  }
}
