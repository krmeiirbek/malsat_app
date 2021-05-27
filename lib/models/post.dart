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
    this.halal,
  });

  int id;
  String title;
  User user;
  City cities;
  String description;
  int price;
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
  String halal;

  factory Post.fromJson(Map<String, dynamic> json) {
    User user = User.fromJson(json['user']);
    Category category = Category.fromJson(json['categories']);
    return Post(
      id: json["id"],
      title: json["title"],
      user: user,
      cities: json['cities'] == null
          ? City(name: '', slug: '', id: 0)
          : City.fromJson(json['cities']),
      description: json["description"],
      price: json["price"],
      exchange: json["exchange"],
      auction: json["auction"],
      delivery: json["delivery"],
      categories: category,
      date: DateFormat("yyyy-MM-dd").parse(json["date"]),
      images: json["images"],
      bookmarks: json["bookmarks"],
      isApproved: json["isApproved"],
      views: json["views"],
      phoneViews: json["phone_views"],
      postViews: json["post_views"],
      bookmarkViews: json["bookmark_views"],
      isHidden: json["isHidden"],
      halal: json["halalimg"],
    );
  }

  String getImage() {
    String url =
        'https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png';
    if (images != null && images.length > 0) {
      if (images[0]['image'][0] != ':') {
        url = images[0]['image'];
      } else
        url = 'http://api.malsat.kz' + images[0]['image'];
    }
    return url;
  }
}
