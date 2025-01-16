import 'package:mr_candy/features/home/data/models/product_model.dart';

abstract class BestSellerProductsStates {}

class BestSellerProductsInitialStates extends BestSellerProductsStates {}

class BestSellerProductsLoadingStates extends BestSellerProductsStates {}

class BestSellerProductsFailureStates extends BestSellerProductsStates {
  final String errorMessage;

  BestSellerProductsFailureStates({required this.errorMessage});
}

class BestSellerProductsSuccessStates extends BestSellerProductsStates {
  final List<ProductModel> products;

  BestSellerProductsSuccessStates({required this.products});
}
