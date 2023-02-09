import 'dart:convert';

import 'package:restaurant_project/data/model/restaurant.dart';

SearchResults searchRestaurantFromJson(String str) =>
    SearchResults.fromJson(json.decode(str));

String searchRestaurantToJson(SearchResults data) => json.encode(data.toJson());

class SearchResults {
  SearchResults({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<Restaurants> restaurants;

  factory SearchResults.fromJson(Map<String, dynamic> json) => SearchResults(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurants>.from(
            json["restaurants"].map((x) => Restaurants.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
