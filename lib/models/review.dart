import 'package:malsat_app/models/user.dart';

class Review {
  int id;
  String comment;
  User user;
  int author;
  int mark;

  Review({
    this.id,
    this.comment,
    this.user,
    this.author,
    this.mark,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    User user = User.fromJson(json['user']);
    return Review(
      id: json['id'],
      comment: json['comment'],
      author: json['author'],
      user: user,
      mark: json['mark'],
    );
  }
}
