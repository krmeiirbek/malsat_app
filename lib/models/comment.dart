import 'package:malsat_app/models/user.dart';

class Comment {
  int id;
  String comment;
  User user;
  int postId;

  Comment({
    this.id,
    this.comment,
    this.user,
    this.postId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    User user = User.fromJson(json['user']);
    return Comment(
      id: json['id'],
      comment: json['comment'],
      postId: json['post'],
      user: user,
    );
  }
}
