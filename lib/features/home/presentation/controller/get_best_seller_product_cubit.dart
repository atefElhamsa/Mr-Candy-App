import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_candy/features/home/data/models/product_model.dart';
import 'package:mr_candy/features/home/data/repos/home_repo_implementation.dart';
import 'package:mr_candy/features/home/presentation/controller/get_best_seller_product_states.dart';
class BestSellerProductsCubit extends Cubit<BestSellerProductsStates> {
  BestSellerProductsCubit() : super(BestSellerProductsInitialStates());
  final HomeRepoImplementation homeRepo = HomeRepoImplementation();
  List<ProductModel> productList = [];
  Future<void> getBestSellerProducts() async {
    emit(BestSellerProductsLoadingStates());
    var result = await homeRepo.getBestSellerProducts();
    result.fold(
      (l) {
        emit(BestSellerProductsFailureStates(errorMessage: l.message));
      },
      (r) {
        productList = r;
        emit(BestSellerProductsSuccessStates(products: productList));
      },
    );
  }
}
