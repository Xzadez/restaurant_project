import 'dart:convert';

import 'package:restaurant_project/data/model/add_review.dart';
import 'package:restaurant_project/data/model/detail_restaurant.dart';
import 'package:restaurant_project/data/model/restaurant.dart';

import 'package:http/http.dart' as http;
import 'package:restaurant_project/data/model/search_restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantResult> allRestoran() async {
    final response = await http.get(Uri.parse(_baseUrl + "list"));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data restaurant');
    }
  }

  Future<DetailResult> detailRestoran(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + "detail/" + id));
    if (response.statusCode == 200) {
      return DetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data restaurant');
    }
  }

  Future<SearchResults> searchRestoran(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + "search?q=" + query));
    if (response.statusCode == 200) {
      return SearchResults.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search data restaurant');
    }
  }

  Future<AddReview> addReviewResto(
      String? id, String? name, String? review) async {
    final response = await http.post(Uri.parse(_baseUrl + "review"),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          "id": id!,
          "name": name!,
          "review": review!,
        }));
    if (response.statusCode == 201) {
      return AddReview.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add review restaurant');
    }
  }
}
