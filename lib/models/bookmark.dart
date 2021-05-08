import 'package:malsat_app/models/post.dart';

class BookMark {
  int id;
  Post post;
  bool inBookmarks;
  int userId;

  BookMark({
    this.id,
    this.post,
    this.inBookmarks,
    this.userId,
  });

  factory BookMark.fromJson(Map<String, dynamic> json) {
    Post post = Post.fromJson(json['post']);
    return BookMark(
      id: json['id'],
      post: post,
      inBookmarks: json['in_bookmarks'],
      userId: json['user'],
    );
  }
}
