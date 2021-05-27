import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:malsat_app/data/data.dart';
import 'package:malsat_app/models/review.dart';

class ReviewRepository {

  Future<List<Review>> getReviews(String author) async {
    final response = await http.get(
      Uri.parse('http://api.malsat.kz/api/review/authorid/$author'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> reviewJson =
      json.decode(utf8.decode(response.bodyBytes));
      return reviewJson.map((json) => Review.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> addReview(String comment, String author, String mark) async {
    final response = await http.post(
      Uri.parse('http://api.malsat.kz/api/review/'),
      headers: {
        'Authorization': 'Bearer $ACCESS_TOKEN',
      },
      body: {
        'comment': comment,
        'author': author,
        'mark': mark,
      },
    );
    print(response.statusCode);
  }
}