import 'package:flutter/foundation.dart';
import 'package:restaurant_project/data/api/api_service.dart';
import 'package:restaurant_project/data/model/restaurant.dart';

import 'result_state.dart';

class RestoProvider extends ChangeNotifier {
  final ApiService? apiService;
  final String? id;
  final String? query;

  RestoProvider({
    this.apiService,
    this.id,
    this.query,
  }) {
    fetchAllRestaurant();
  }

  RestaurantResult? _restaurantResult;
  ResultState? _state;
  String _message = '';

  //GET

  String get message => _message;
  RestaurantResult get result => _restaurantResult!;
  ResultState get state => _state!;

  Future<dynamic> fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService?.allRestoran();
      if (restaurant!.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
