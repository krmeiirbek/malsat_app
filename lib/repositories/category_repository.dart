import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:malsat_app/models/category.dart';

class CategoryRepository {
  static String mainUrl = "http://api.malsat.kz";
  var getCategoryUrl = "$mainUrl/api/categories/";

  Future<List<Category>> getAllCategories() async{
    final response = await http.get(Uri.parse(getCategoryUrl));
    print("status Code: "+ response.statusCode.toString());
    if(response.statusCode == 200){
      final List<dynamic> categoryJson = json.decode(utf8.decode(response.bodyBytes));
      return categoryJson.map((json) => Category.fromJson(json)).toList();
    }else{
      return null;
    }
  }
}