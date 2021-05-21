import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:malsat_app/data/data.dart';
import 'package:malsat_app/models/post.dart';

class PostRepository {
  static String mainUrl = "http://api.malsat.kz";
  var getAllPostsApprovedNotHiddenUrl = "$mainUrl/api/posts/";
  var createPostUrl = "$mainUrl/api/posts/";
  var getMyActivePostsUrl = "$mainUrl/api/authorposts/";
  var getMyHiddenPostsUrl = "$mainUrl/api/hidden/posts/";
  var getMyCheckingPostsUrl = "$mainUrl/api/user/checking/posts/";
  var getAllPostsWithKeyWordUrl = "$mainUrl/api/product/";

  Future<List<Post>> getAllPostsApprovedNotHidden() async {
    final response = await http.get(
      Uri.parse(getAllPostsApprovedNotHiddenUrl),
      headers: {
        'Authorization': 'Bearer $ACCESS_TOKEN',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> postsJson =
          json.decode(utf8.decode(response.bodyBytes));
      return postsJson.map((json) => Post.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<List<Post>> getAllPostsWithKeyWord(String keyWord) async {
    final response = await http.get(
      Uri.parse(getAllPostsWithKeyWordUrl + '?search=$keyWord'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> postsJson =
          json.decode(utf8.decode(response.bodyBytes));
      return postsJson.map((json) => Post.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<List<Post>> getAllPostsWithCity(int cityId) async {
    final response = await http.get(
      Uri.parse(getAllPostsWithKeyWordUrl + '?cities=$cityId'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> postsJson =
          json.decode(utf8.decode(response.bodyBytes));
      return postsJson.map((json) => Post.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<List<Post>> getMyPosts() async {
    final response = await http.get(
      Uri.parse(getMyActivePostsUrl),
      headers: {
        'Authorization': 'Bearer $ACCESS_TOKEN',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> postsJson =
          json.decode(utf8.decode(response.bodyBytes));
      return postsJson.map((json) => Post.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<List<Post>> getMyActivePosts() async {
    final response = await http.get(
      Uri.parse(getMyActivePostsUrl),
      headers: {
        'Authorization': 'Bearer $ACCESS_TOKEN',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> postsJson =
          json.decode(utf8.decode(response.bodyBytes));
      return postsJson.map((json) => Post.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<String> createPost(String title, String description, int price,
      bool exchange, bool auction, bool delivery) async {
    final response = await http.post(Uri.parse(createPostUrl));
    // if (response.statusCode == 200) {
    //   final List<dynamic> postsJson =
    //   json.decode(utf8.decode(response.bodyBytes));
    //   print(postsJson);
    //   return postsJson.map((json) => Post.fromJson(json)).toList();
    // } else {
    //   return [];
    // }
  }

  Future<List<Post>> getMyHiddenPosts() async {
    final response = await http.get(
      Uri.parse(getMyHiddenPostsUrl),
      headers: {
        'Authorization': 'Bearer $ACCESS_TOKEN',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> postsJson =
          json.decode(utf8.decode(response.bodyBytes));
      return postsJson.map((json) => Post.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<List<Post>> getMyCheckingPosts() async {
    final response = await http.get(
      Uri.parse(getMyCheckingPostsUrl),
      headers: {
        'Authorization': 'Bearer $ACCESS_TOKEN',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> postsJson =
          json.decode(utf8.decode(response.bodyBytes));
      return postsJson.map((json) => Post.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}
