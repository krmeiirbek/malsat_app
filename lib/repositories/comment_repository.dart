import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:malsat_app/data/data.dart';
import 'package:malsat_app/models/comment.dart';

class CommentRepository{
  static String mainUrl = "http://api.malsat.kz";
  var getOrAddCommentUrl = "$mainUrl/api/comments/";

  Future<List<Comment>> getComment1() async {
    final response = await http.get(
      Uri.parse(getOrAddCommentUrl),
    );
    if (response.statusCode == 200) {
      final List<dynamic> commentJson =
      json.decode(utf8.decode(response.bodyBytes));
      return commentJson.map((json) => Comment.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> addComment(String comment,String postId) async {
    final response = await http.post(
      Uri.parse(getOrAddCommentUrl),
      headers: {
        'Authorization': 'Bearer $ACCESS_TOKEN',
      },
      body: {
        'comment': comment,
        'post': postId,
      },
    );
    print(response.statusCode);
  }
}