import 'package:flutter/cupertino.dart';
import 'package:restaurant_project/data/api/api_service.dart';
import 'package:restaurant_project/data/model/detail_restaurant.dart';

import 'result_state.dart';

class DetailProvider extends ChangeNotifier {
  final ApiService? apiService;
  final String? id;

  DetailProvider({this.apiService, this.id}) {
    _fetchDetailRestaurant();
  }

  DetailResult? _detailResult;
  ResultState? _state;
  String _message = '';

  //GET

  String get message => _message;
  DetailResult? get detailResult => _detailResult;
  ResultState? get state => _state;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService!.detailRestoran(id!);
      if (restaurant.restaurant.menus.drinks.isEmpty ||
          restaurant.restaurant.menus.foods.isEmpty ||
          restaurant.restaurant.categories.isEmpty ||
          restaurant.restaurant.customerReviews.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _detailResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
