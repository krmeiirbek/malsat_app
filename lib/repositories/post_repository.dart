import 'dart:convert';

import 'package:flutter/cupertino.dart';
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

  Future<List<Post>> getAllPostsWithCategory(int categoriesId) async {
    final response = await http.get(
      Uri.parse(getAllPostsWithKeyWordUrl + '?categories=$categoriesId'),
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

  Future<bool> addPost({
    @required String title,
    @required String description,
    @required String price,
    @required String exchange,
    @required String auction,
    @required String delivery,
    @required String categoriesId,
    @required String citiesId,
    String units = "1",
    String numOfItem = "1",
  }) async {
    final response = await http.post(
      Uri.parse(createPostUrl),
      headers: {
        'Authorization': 'Bearer $ACCESS_TOKEN',
      },
      body: {
        "title": title,
        "categories": categoriesId,
        "cities": citiesId,
        "description": description,
        "price": price,
        "exchange":exchange,
        "auction":auction,
        "delivery":delivery,
        "units": units,
        "numOfItem": numOfItem,
      },
    );
    if(response.statusCode == 201){
      print("post added");
      print(json.decode(response.body)["id"]);
      return true;
    }
    return false;
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
