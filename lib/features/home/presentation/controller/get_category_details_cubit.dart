import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_candy/features/home/presentation/controller/get_category_details_states.dart';

import '../../data/repos/home_repo.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsStates> {
  CategoryDetailsCubit({required this.homeRepo})
      : super(CategoryDetailsInitialStates());
  final HomeRepo homeRepo;
  Future<void> getCategoryDetails({required int categoryId}) async {
    emit(CategoryDetailsLoadingStates());
    var result = await homeRepo.getCategoryDetails(id: categoryId);
    result.fold(
      (l) {
        emit(CategoryDetailsFailureStates(errorMessage: l.message));
      },
      (r) {
        emit(CategoryDetailsSuccessStates(categoryDetails: r));
      },
    );
  }
}
