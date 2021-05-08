import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:malsat_app/data/data.dart';
import 'package:malsat_app/models/bookmark.dart';

class BookmarkRepository {
  static String mainUrl = "http://api.malsat.kz";
  var getBookmarkUrl = "$mainUrl/api/bookmarks/";

  Future<List<BookMark>> getAllBookmarks() async {
    final response = await http.get(
      Uri.parse(getBookmarkUrl),
      headers: {
        'Authorization': 'Bearer $ACCESS_TOKEN',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> bookmarkJson =
          json.decode(utf8.decode(response.bodyBytes));
      return bookmarkJson.map((json) => BookMark.fromJson(json)).toList();
    } else {
      return null;
    }
  }
}
