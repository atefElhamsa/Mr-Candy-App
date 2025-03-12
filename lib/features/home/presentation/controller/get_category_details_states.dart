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
