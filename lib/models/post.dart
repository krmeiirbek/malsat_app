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
  City city;
  String description;
  String price;
  bool exchange;
  bool auction;
  bool delivery;
  Category category;
  DateTime date;
  List<dynamic> images;
  List<dynamic> bookmarks;
  bool isApproved;
  int views;
  List<dynamic> phoneViews;
  List<dynamic> postViews;
  List<dynamic> bookmarkViews;
  bool isHidden;

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      id: json["id"],
      title: json["title"],
      user: json["user"],
      city: json["cities"],
      description: json["description"],
      price: json["price"],
      exchange: json["exchange"],
      auction: json["auction"],
      delivery: json["delivery"],
      category: json["categories"],
      date: json["date"],
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
