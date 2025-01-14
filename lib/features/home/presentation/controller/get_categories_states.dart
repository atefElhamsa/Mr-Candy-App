import 'package:mr_candy/features/home/data/models/category_model.dart';

abstract class CategoriesStates {}

class CategoriesInitialStates extends CategoriesStates {}

class CategoriesLoadingStates extends CategoriesStates {}

class CategoriesFailureStates extends CategoriesStates {
  final String errorMessage;

  CategoriesFailureStates({required this.errorMessage});
}

class CategoriesSuccessStates extends CategoriesStates {
  final List<CategoryModel> categories;

  CategoriesSuccessStates({required this.categories});
}
