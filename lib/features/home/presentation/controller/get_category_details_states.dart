import 'package:mr_candy/features/favourite/data/model/favourite_model.dart';
import 'package:mr_candy/features/home/data/models/product_model.dart';

abstract class CategoryDetailsStates {}

class CategoryDetailsInitialStates extends CategoryDetailsStates {}

class CategoryDetailsLoadingStates extends CategoryDetailsStates {}

class CategoryDetailsFailureStates extends CategoryDetailsStates {
  final String errorMessage;

  CategoryDetailsFailureStates({required this.errorMessage});
}

class CategoryDetailsSuccessStates extends CategoryDetailsStates {
  final List<ProductModel> categoryDetails;

  CategoryDetailsSuccessStates({required this.categoryDetails});
}

class AddCategoryFavouriteLoadingStates extends CategoryDetailsStates {}

class AddCategoryFavouriteFailureStates extends CategoryDetailsStates {
  final String errorMessage;

  AddCategoryFavouriteFailureStates({required this.errorMessage});
}

class AddCategoryFavouriteSuccessStates extends CategoryDetailsStates {
  final List<FavouriteItemModel> favouriteList;

  AddCategoryFavouriteSuccessStates({required this.favouriteList});
}
