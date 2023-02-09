import 'package:flutter/cupertino.dart';
import 'package:restaurant_project/data/model/search_restaurant.dart';
import 'package:restaurant_project/provider/result_state.dart';

import '../data/api/api_service.dart';

class SearchProvider extends ChangeNotifier {
  SearchResults? _searchResults;
  ResultState? _state;
  String _message = '';

  //GET

  String get message => _message;
  SearchResults? get searchResults => _searchResults;
  ResultState? get state => _state;

  Future<dynamic> searchRestaurant(ApiService apiService, String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.searchRestoran(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Not Found';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _searchResults = restaurant;
      }
    } catch (e) {
      if (query == '') {
        _state = ResultState.Error;
        notifyListeners();
        return _message = 'Cari';
      } else {
        _state = ResultState.Error;
        notifyListeners();
        return _message = 'Error --> $e';
      }
    }
  }
}
