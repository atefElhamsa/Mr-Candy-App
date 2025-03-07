import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_candy/features/home/data/models/product_model.dart';
import 'package:mr_candy/features/home/presentation/controller/get_category_details_states.dart';

import '../../data/repos/home_repo.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsStates> {
  CategoryDetailsCubit({required this.homeRepo})
      : super(CategoryDetailsInitialStates());
  final HomeRepo homeRepo;
  List<ProductModel> categoryDetails = [];
  Future<void> getCategoryDetails({required int categoryId}) async {
    emit(CategoryDetailsLoadingStates());
    var result = await homeRepo.getCategoryDetails(id: categoryId);
    result.fold(
      (l) {
        emit(CategoryDetailsFailureStates(errorMessage: l.message));
      },
      (r) {
        categoryDetails = r;
        emit(CategoryDetailsSuccessStates(categoryDetails: categoryDetails));
      },
    );
  }
}
