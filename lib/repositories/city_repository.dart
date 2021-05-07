import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:malsat_app/models/city.dart';

class CityRepository {
  static String mainUrl = "http://api.malsat.kz";
  var getCitiesUrl = "$mainUrl/api/cities/";
  var addCityUrl = "$mainUrl/api/cities/";
  var updateCityUrl = "$mainUrl/api/cities/8/";
  var deleteCityUrl = "$mainUrl/api/cities/8/";

  Future<List<City>> getAllCities() async{
    final response = await http.get(Uri.parse(getCitiesUrl));
    if(response.statusCode == 200){
      final List<dynamic> cityJson = json.decode(utf8.decode(response.bodyBytes));
      return cityJson.map((json) => City.fromJson(json)).toList();
    }else{
      return null;
    }
  }
}