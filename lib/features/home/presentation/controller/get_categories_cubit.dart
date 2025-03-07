import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_candy/features/home/data/models/category_model.dart';
import 'package:mr_candy/features/home/data/repos/home_repo.dart';
import 'package:mr_candy/features/home/data/repos/home_repo_implementation.dart';
import 'package:mr_candy/features/home/presentation/controller/get_categories_states.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  CategoriesCubit() : super(CategoriesInitialStates());
  final HomeRepoImplementation homeRepo = HomeRepoImplementation();
  List<CategoryModel> categoriesList = [];
  Future<void> getCategories() async {
    emit(CategoriesLoadingStates());
    var result = await homeRepo.getCategories();
    result.fold(
      (l) {
        emit(CategoriesFailureStates(errorMessage: l.message));
      },
      (r) {
        categoriesList = r;
        emit(CategoriesSuccessStates(categories: categoriesList));
      },
    );
  }
}
