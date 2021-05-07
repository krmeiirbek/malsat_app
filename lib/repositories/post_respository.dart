import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:malsat_app/models/city.dart';
import 'package:malsat_app/models/post.dart';

class PostRepository {
  static String mainUrl = "http://api.malsat.kz";
  var getAllPostsApprovedNotHiddenUrl = "$mainUrl/api/posts/";

  Future<List<Post>> getAllPostsApprovedNotHidden() async {
    final response = await http.get(Uri.parse(getAllPostsApprovedNotHiddenUrl));
    if (response.statusCode == 200) {
      final List<dynamic> postsJson =
          json.decode(utf8.decode(response.bodyBytes));
      return postsJson.map((json) => Post.fromJson(json)).toList();
    } else {
      return null;
    }
  }
}
