import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_candy/features/favourite/data/repo/favourite_repo_implementation.dart';
import 'package:mr_candy/features/home/data/models/product_model.dart';
import 'package:mr_candy/features/home/presentation/controller/get_category_details_states.dart';

import '../../data/repos/home_repo.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsStates> {
  CategoryDetailsCubit({required this.homeRepo})
      : super(CategoryDetailsInitialStates());
  final HomeRepo homeRepo;
  final FavouriteRepoImplementation favouriteRepoImplementation =
      FavouriteRepoImplementation();
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

  Future<void> addFavourite({
    required BuildContext context,
    required int index,
  }) async {
    emit(AddCategoryFavouriteLoadingStates());
    final result = await favouriteRepoImplementation.addFavourite(
      context: context,
      index: index,
    );
    result.fold(
      (l) {
        emit(AddCategoryFavouriteFailureStates(errorMessage: l.message));
      },
      (r) {
        emit(
          AddCategoryFavouriteSuccessStates(
            favouriteList: List.from(
              categoryDetails.where((element) => element.inFavorites == true),
            ),
          ),
        );
      },
    );
  }
}
