import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_candy/features/home/presentation/controller/get_best_seller_product_states.dart';

import '../../data/repos/home_repo.dart';

class BestSellerProductsCubit extends Cubit<BestSellerProductsStates> {
  BestSellerProductsCubit({required this.homeRepo})
      : super(BestSellerProductsInitialStates());
  final HomeRepo homeRepo;
  Future<void> getBestSellerProducts() async {
    emit(BestSellerProductsLoadingStates());
    var result = await homeRepo.getBestSellerProducts();
    result.fold(
      (l) {
        emit(BestSellerProductsFailureStates(errorMessage: l.message));
      },
      (r) {
        emit(BestSellerProductsSuccessStates(products: r));
      },
    );
  }
}
