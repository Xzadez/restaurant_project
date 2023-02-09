import 'package:flutter/cupertino.dart';
import 'package:restaurant_project/data/api/api_service.dart';
import 'package:restaurant_project/data/model/add_review.dart';
import 'package:restaurant_project/provider/result_state.dart';

class AddReviewProvider extends ChangeNotifier {
  AddReview? _addReview;
  ResultState? _state;
  String _message = '';

  bool _isAdding = false;

  //GET

  bool get isAdding => _isAdding;
  String get message => _message;
  AddReview? get addReview => _addReview;
  ResultState? get state => _state;

  set isAdding(bool value) {
    _isAdding = value;
    notifyListeners();
  }

  Future<dynamic> addReviewRestaurant(
      ApiService apiService, String? id, String? name, String? review) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final reviews = await apiService.addReviewResto(id, name, review);
      if (reviews.customerReviews.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _addReview = reviews;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
